---Marks.nvim highlight groups.
local M = {}

---Get Marks.nvim highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights Marks.nvim highlight group definitions.
function M.get(c, _)
	return {
		MarkSignHL = { fg = c.base.blue, bold = true },
		MarkSignNumHL = { fg = c.base.blue },
		MarkVirtTextHL = { fg = c.base.dimmed3, italic = true },
	}
end

return M
