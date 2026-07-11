---nvim-ufo highlight groups.
local M = {}

---Get nvim-ufo highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights nvim-ufo highlight group definitions.
function M.get(c, _)
	return {
		UfoFoldedBg = { bg = c.editor.background },
		FoldColumn = {
			bg = c.editor.background,
			fg = c.button.foreground,
		},
	}
end

return M
