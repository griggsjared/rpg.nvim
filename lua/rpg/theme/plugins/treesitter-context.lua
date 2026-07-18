---Treesitter Context highlight groups.
local M = {}

---Get Treesitter Context highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights Treesitter Context highlight group definitions.
function M.get(c, _)
	return {
		TreesitterContext = { bg = c.base.overlay, fg = c.base.foreground },
		TreesitterContextBottom = { bg = c.base.overlay, sp = c.base.dimmed5 },
		TreesitterContextLineNumber = { bg = c.base.overlay, fg = c.base.dimmed3 },
		TreesitterContextSeparator = { fg = c.base.dimmed5 },
	}
end

return M
