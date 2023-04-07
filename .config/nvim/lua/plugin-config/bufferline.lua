vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },

        separator_style = "slant",
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center"
        },
        {
            filetype = "Outline",
            text = "File Overview",
            highlight = "Directory",
            text_align = "center"
        },
        {
            filetype = "Trouble",
            text = "Diagnostics",
            highlight = "Directory",
            text_align = "bottom"
        },
        },
    }
}

