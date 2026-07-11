local M = {}

---Discover all plugin integration modules under lua/rpg/theme/plugins/.
---@return string[] plugin_names Sorted list of module basenames.
local function discover_plugins()
	local files = vim.api.nvim_get_runtime_file("lua/rpg/theme/plugins/*.lua", true)
	local seen = {}
	local plugins = {}

	for _, path in ipairs(files) do
		local name = vim.fn.fnamemodify(path, ":t:r")

		-- Skip init.lua so it is never loaded as a plugin integration.
		if not seen[name] and name ~= "init" then
			seen[name] = true
			table.insert(plugins, name)
		end
	end

	table.sort(plugins)

	return plugins
end

---Get highlight definitions for plugin integrations.
---@param c table Colorscheme color table.
---@param hp table Helper functions/modules.
---@param enabled boolean|table|nil `true` or `nil` for all discovered integrations, `false` for none, or a table of integration names.
---@return table<string, table> highlights Mapping of highlight group names to their settings.
function M.get(c, hp, enabled)
	local highlights = {}

	if enabled == false then
		return highlights
	end

	local list

	if enabled == nil or enabled == true then
		list = discover_plugins()
	elseif type(enabled) == "table" then
		list = enabled
	else
		vim.notify(
			("[rpg.nvim] invalid plugins option (got %s): expected true, false, or table; using discovered plugins"):format(type(enabled)),
			vim.log.levels.WARN
		)
		list = discover_plugins()
	end

	for _, plugin in ipairs(list) do
		if type(plugin) == "string" then
			local ok, module = pcall(require, "rpg.theme.plugins." .. plugin)
			if ok then
				highlights = vim.tbl_deep_extend("force", highlights, module.get(c, hp))
			end
		end
	end

	return highlights
end

return M
