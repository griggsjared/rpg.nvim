---Render Markdown highlight groups.
local M = {}

---Get Render Markdown highlight definitions.
---@param c table Colorscheme color table.
---@param hp table Helper functions/modules.
---@return table<string, table> highlights Render Markdown highlight group definitions.
function M.get(c, hp)
	return {
		RenderMarkdownH1 = { fg = c.base.green },
		RenderMarkdownH2 = { fg = c.base.magenta },
		RenderMarkdownH3 = { fg = c.base.yellow },
		RenderMarkdownH4 = { fg = c.base.cyan },
		RenderMarkdownH5 = { fg = c.base.red },
		RenderMarkdownH6 = { fg = c.base.blue },
		RenderMarkdownH1Bg = { bg = c.base.background },
		RenderMarkdownH2Bg = { bg = c.base.background },
		RenderMarkdownH3Bg = { bg = c.base.background },
		RenderMarkdownH4Bg = { bg = c.base.background },
		RenderMarkdownH5Bg = { bg = c.base.background },
		RenderMarkdownH6Bg = { bg = c.base.background },
		RenderMarkdownCode = { bg = c.base.background },
		RenderMarkdownCodeInline = { bg = c.base.background },
		RenderMarkdownCodeInfo = { fg = c.base.dimmed2 },
		RenderMarkdownCodeBorder = { fg = c.base.dimmed4 },
		RenderMarkdownQuote = { fg = c.base.foreground },
		RenderMarkdownBullet = { fg = c.base.dimmed2 },
		RenderMarkdownDash = { fg = c.base.dimmed2 },
		RenderMarkdownTableHead = { fg = c.base.yellow },
		RenderMarkdownTableRow = { fg = c.base.foreground },
		RenderMarkdownLink = { fg = c.base.cyan },
		RenderMarkdownSign = { fg = c.base.dimmed3 },
		RenderMarkdownMath = { fg = c.base.cyan },
	}
end

return M
