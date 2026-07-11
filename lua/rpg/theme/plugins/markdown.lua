---Render Markdown highlight groups.
local M = {}

---Get Render Markdown highlight definitions.
---@param c table Colorscheme color table.
---@param hp table Helper functions/modules.
---@return table<string, table> highlights Render Markdown highlight group definitions.
function M.get(c, hp)
  return {
    RenderMarkdownHeader1 = { fg = c.base.green },
    RenderMarkdownHeader2 = { fg = c.base.magenta },
    RenderMarkdownHeader3 = { fg = c.base.yellow },
    RenderMarkdownHeader4 = { fg = c.base.cyan },
    RenderMarkdownHeader5 = { fg = c.base.red },
    RenderMarkdownHeader6 = { fg = c.base.blue },
    RenderMarkdownCode = { bg = c.base.background },
    RenderMarkdownCodeInline = { bg = c.base.background },
  }
end

return M
