---Lazy.nvim highlight groups.
local M = {}

---Get Lazy.nvim highlight definitions.
---@param c table Colorscheme color table.
---@param hp table Helper functions/modules.
---@return table<string, table> highlights Lazy.nvim highlight group definitions.
function M.get(c, hp)
	return {
		LazyButton = { bg = c.button.background, fg = c.button.foreground },
		LazyComment = { fg = c.base.yellow },
		LazyH1 = { bg = c.base.yellow, fg = c.base.background, bold = true },
		LazyH2 = { fg = c.base.green, bold = true },
		LazyButtonActive = {
			bg = c.button.hoverBackground,
			fg = c.button.foreground,
			bold = true,
		},
		LazyNormal = {
			bg = c.base.overlay,
			fg = hp.lighten(c.sideBar.foreground, 5),
		},
		LazyProgressDone = { bg = c.base.overlay, fg = c.tab.activeBorder },
		LazyProgressTodo = {
			bg = c.base.overlay,
			fg = c.tab.unfocusedActiveBorder,
		},
		LazyProp = {
			bg = c.base.overlay,
			fg = c.base.green,
		},
		LazyUrl = { fg = c.base.blue },
		LazyDir = { link = "LazyUrl" },
		LazySpecial = { fg = c.base.yellow, bold = true },
		LazyReasonStart = { fg = c.base.green },
		LazyReasonCmd = { fg = c.base.blue },
	}
end

return M
