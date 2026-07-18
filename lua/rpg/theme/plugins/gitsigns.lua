---Gitsigns integration: highlight groups and blame color overrides.
local M = {}

---Convert a hex color string to an RGB table.
---@param hex string Hex color string.
---@return table RGB color table.
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

---Swap an upvalue on a function.
---@param fn function Function to modify.
---@param name string Upvalue name to swap.
---@param new_val any New value for the upvalue.
---@return any Previous value if swapped, nil otherwise.
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

---Generate a temporary highlight group for gitsigns blame.
---@param min number Minimum value.
---@param max number Maximum value.
---@param t number Current value.
---@param alpha number Alpha blend value.
---@param fg boolean Whether to use foreground.
---@return string Highlight group name.
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

---Map a commit SHA to one of the palette highlight groups.
---@param sha string Commit SHA string.
---@return string Highlight group name.
local function rpg_get_hash_color(sha)
	local sum = 0
	for i = 1, #sha do
		sum = sum + sha:byte(i)
	end
	return hash_hls[(sum % #hash_hls) + 1]
end

---Iterate over each function upvalue in gitsigns blame.
---@param fn function Callback function for each upvalue.
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

---Set up gitsigns color overrides and blame highlighting.
---@param c table Colorscheme color table.
---@return boolean True if gitsigns was found and set up.
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

---Restore gitsigns original color functions.
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

---Get gitsigns highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights Gitsigns highlight group definitions.
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
		GitSignsAdd = { fg = c.editorGutter.addedBackground },
		GitSignsChange = { fg = c.editorGutter.modifiedBackground },
		GitSignsDelete = { fg = c.editorGutter.deletedBackground },
		GitSignsCurrentLineBlame = { fg = c.base.dimmed4 },
		GitSignsAddInline = { link = "DiffAdd" },
		GitSignsChangeInline = { link = "DiffChange" },
		GitSignsDeleteInline = { link = "DiffDelete" },
	}
end

return M