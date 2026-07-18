---Oil.nvim highlight groups.
local M = {}

---Get Oil.nvim highlight definitions.
---@param c table Colorscheme color table.
---@param _ table Helper functions/modules (unused).
---@return table<string, table> highlights Oil.nvim highlight group definitions.
function M.get(c, _)
	return {
		OilEmpty = { fg = c.base.dimmed3 },
		OilHidden = { fg = c.base.dimmed3 },
		OilDir = { fg = c.base.blue },
		OilDirIcon = { fg = c.base.blue },
		OilSocket = { fg = c.base.red },
		OilFile = { fg = c.base.foreground },
		OilLink = { fg = c.base.magenta },
		OilOrphanLink = { fg = c.base.red },
		OilLinkTarget = { fg = c.base.dimmed3 },
		OilOrphanLinkTarget = { fg = c.base.red },
		OilCopy = { fg = c.base.yellow, bold = true },
		OilMove = { fg = c.base.magenta, bold = true },
		OilChange = { fg = c.base.blue, bold = true },
		OilCreate = { fg = c.base.green, bold = true },
		OilDelete = { fg = c.base.red, bold = true },
		OilTrashSourcePath = { fg = c.base.dimmed3 },
	}
end

return M
