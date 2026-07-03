# rpg.nvim

A dark Neovim colorscheme with colors inspired by gear rarity colors from your favorite RPGs.

## Palette

| Color   | Hex       | Preview |
|---------|-----------|---------|
| Red     | `#d9726c` | ![#d9726c](https://placehold.co/16x16/d9726c/d9726c) |
| Orange  | `#e6975c` | ![#e6975c](https://placehold.co/16x16/e6975c/e6975c) |
| Yellow  | `#d9b85c` | ![#d9b85c](https://placehold.co/16x16/d9b85c/d9b85c) |
| Green   | `#7acc5c` | ![#7acc5c](https://placehold.co/16x16/7acc5c/7acc5c) |
| Blue    | `#4a8cbd` | ![#4a8cbd](https://placehold.co/16x16/4a8cbd/4a8cbd) |
| Magenta | `#9d6ac4` | ![#9d6ac4](https://placehold.co/16x16/9d6ac4/9d6ac4) |

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "griggsjared/rpg.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("rpg").setup()
        vim.cmd([[colorscheme rpg]])
    end,
}
```

## Configuration

```lua
require("rpg").setup({
    -- Enable transparent background
    transparent_background = false,
    -- Override specific highlight groups
    highlight_overrides = {
        -- Example: make comments brighter
        -- Comment = { fg = "#939293", italic = true },
    },
})
```

## Plugin Support

rpg.nvim currently includes highlight definitions for:

- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- [marks.nvim](https://github.com/chentoast/marks.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [oil.nvim](https://github.com/stevearc/oil.nvim)
- [quicker.nvim](https://github.com/stevearc/quicker.nvim)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)

## License

MIT
