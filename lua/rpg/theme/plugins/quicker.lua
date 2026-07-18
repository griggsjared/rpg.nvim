---Quicker.nvim highlight groups.
local M = {}

---Get Quicker.nvim highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights Quicker.nvim highlight group definitions.
function M.get(c, _)
	return {
		QuickFixLine = { bg = c.base.dimmed5, fg = c.base.foreground },
		QuickFixHeaderHard = { fg = c.base.green, bold = true },
		QuickFixHeaderSoft = { fg = c.base.dimmed2 },
		QuickFixFilename = { fg = c.base.blue, bold = true },
		QuickFixFilenameInvalid = { fg = c.base.dimmed3 },
		QuickFixLineNr = { fg = c.base.dimmed2 },
		QuickFixText = { fg = c.base.foreground },
		QuickFixTextInvalid = { fg = c.base.dimmed3 },
	}
end

return M
