---Snacks.nvim highlight groups.
local M = {}

---Get Snacks.nvim highlight definitions.
---@param c table Colorscheme color table.
---@param hp table Helper functions/modules.
---@return table<string, table> highlights Snacks.nvim highlight group definitions.
function M.get(c, hp)
	return {
		SnacksIndent = { fg = c.base.dimmed5 },
		SnacksIndentScope = { fg = hp.blend(c.base.green, 0.6, c.editor.background) },
		SnacksDashboardNormal = { bg = c.editor.background, fg = c.editor.foreground },
		SnacksDashboardDesc = { fg = c.base.dimmed1 },
		SnacksDashboardIcon = { fg = c.base.blue },
		SnacksDashboardHeader = { fg = c.base.green },
		SnacksPicker = { bg = c.base.overlay },
		SnacksPickerBorder = { bg = c.base.overlay, fg = c.base.dimmed2 },
		SnacksPickerPreview = { bg = c.base.overlay },
		SnacksPickerDir = { fg = c.base.dimmed1 },
		SnacksPickerCursorLine = { bg = c.base.dimmed5 },
		SnacksPickerListCursorLine = { bg = c.base.dimmed5 },
		SnacksPickerBoxCursorLine = { bg = c.base.dimmed5 },
		SnacksPickerBufFlags = { fg = c.base.red },
		SnacksPickerCol = { fg = c.base.blue, bg = "none" },
		SnacksPickerPathIgnored = { fg = c.base.dimmed1 },
		SnacksPickerUnselected = { fg = c.base.dimmed1 },
		SnacksPickerPathHidden = { fg = c.base.dimmed1 },
		SnacksPickerKeymapRhs = { fg = c.base.dimmed1 },
		SnacksPickerTotals = { fg = c.base.dimmed1 },
		SnacksPickerGitStatusIgnored = { fg = c.base.dimmed1 },
		SnacksPickerGitStatusUntracked = { fg = c.base.dimmed1 },
	}
end

return M
