local M = {}

local function hex_to_rgb(hex)
	return {
		tonumber(hex:sub(2, 3), 16),
		tonumber(hex:sub(4, 5), 16),
		tonumber(hex:sub(6, 7), 16),
	}
end

local saved = {}
local temp_colors = {}
local hash_hls = {}

--- swap upvalue `name` on fn; return previous value if swapped
local function swap_upvalue(fn, name, new_val)
	local i = 1
	while true do
		local n, val = debug.getupvalue(fn, i)
		if not n then
			return
		end
		if n == name and type(val) == "function" then
			debug.setupvalue(fn, i, new_val)
			return val
		end
		i = i + 1
	end
end

--- like gitsigns.get_temp_hl but re-reads Normal bg each call (no stale cache)
local function rpg_get_temp_hl(min, max, t, alpha, fg)
	local Color = require("gitsigns.color")
	local denom = math.max(max, t) - min
	local nt = denom ~= 0 and (t - min) / denom or 0
	local norm = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	local bg = norm and Color.int_to_rgb(norm)
		or (vim.o.background == "light" and { 255, 255, 255 } or { 0, 0, 0 })
	local color = Color.rgb_to_int(Color.blend(Color.temp(nt), bg, alpha))
	if temp_colors[color] then
		return temp_colors[color]
	end
	local key = fg and "fg" or "bg"
	local hl = ("GitSignsColorTemp.%s.%d"):format(key, color)
	vim.api.nvim_set_hl(0, hl, { [key] = color })
	temp_colors[color] = hl
	return hl
end

--- map a commit SHA to one of the palette highlight groups
local function rpg_get_hash_color(sha)
	local sum = 0
	for i = 1, #sha do
		sum = sum + sha:byte(i)
	end
	return hash_hls[(sum % #hash_hls) + 1]
end

local function for_each_blame_upvalue(fn)
	if not pcall(require, "gitsigns.actions.blame") then
		return
	end
	local blame = require("gitsigns.actions.blame").blame
	if type(blame) ~= "function" then
		return
	end
	local i = 1
	while true do
		local _, up = debug.getupvalue(blame, i)
		if not up then
			break
		end
		if type(up) == "function" then
			fn(up)
		end
		i = i + 1
	end
end

function M.setup(c)
	if not pcall(require, "gitsigns.color") then
		return false
	end
	local Color = require("gitsigns.color")
	local Highlight = require("gitsigns.highlight")

	saved.temp = saved.temp or Color.temp
	saved.get_temp_hl = saved.get_temp_hl or Highlight.get_temp_hl
	Color.temp = function(v)
		return Color.gradient({ hex_to_rgb(c.base.blue), hex_to_rgb(c.base.red), hex_to_rgb(c.base.yellow) }, v)
	end
	Highlight.get_temp_hl = rpg_get_temp_hl
	temp_colors = {}

	hash_hls = {}
	for _, col in ipairs({ c.base.red, c.base.cyan, c.base.yellow, c.base.green, c.base.blue, c.base.magenta }) do
		local hl = ("RpgGitSignsBlameColor.%d"):format(#hash_hls + 1)
		vim.api.nvim_set_hl(0, hl, { fg = col })
		table.insert(hash_hls, hl)
	end
	for_each_blame_upvalue(function(up)
		local orig = swap_upvalue(up, "get_hash_color", rpg_get_hash_color)
		if orig and not saved.get_hash_color then
			saved.get_hash_color = orig
		end
	end)

	return true
end

local function restore()
	if not pcall(require, "gitsigns.color") then
		return
	end
	local Color = require("gitsigns.color")
	local Highlight = require("gitsigns.highlight")
	if saved.temp then
		Color.temp = saved.temp
	end
	if saved.get_temp_hl then
		Highlight.get_temp_hl = saved.get_temp_hl
	end
	temp_colors = {}
	if saved.get_hash_color then
		for_each_blame_upvalue(function(up)
			swap_upvalue(up, "get_hash_color", saved.get_hash_color)
		end)
	end
end

function M.get(c, _)
	M.setup(c)
	local group = vim.api.nvim_create_augroup("rpg.gitsigns", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			if vim.g.colors_name == "rpg" then
				M.setup(c)
			else
				restore()
			end
		end,
	})
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = group,
		callback = function()
			if M.setup(c) then
				vim.api.nvim_clear_autocmds({ group = group, event = "BufReadPost" })
			end
		end,
	})
	return {
		SignAdd = { fg = c.editorGutter.addedBackground },
		SignChange = { fg = c.editorGutter.modifiedBackground },
		SignDelete = { fg = c.editorGutter.deletedBackground },
		GitSignsAdd = { link = "SignAdd" },
		GitSignsChange = { link = "SignChange" },
		GitSignsDelete = { link = "SignDelete" },
		GitSignsCurrentLineBlame = { fg = c.base.dimmed4 },
		GitSignsAddInline = { link = "DiffAdd" },
		GitSignsChangeInline = { link = "DiffChange" },
		GitSignsDeleteInline = { link = "DiffDelete" },
	}
end

return M