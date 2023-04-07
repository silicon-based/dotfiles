require('basic')
require('plugins')
require('keymapping')
require('plugin-config/init')
require('lsp.init')
require("luasnip.loaders.from_vscode").lazy_load()

vim.cmd(':set clipboard+=unnamedplus')
vim.cmd('autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2')
vim.cmd('autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2')
vim.cmd('autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2')
if vim.g.neovide then
    vim.cmd(":set guifont=JetBrainsMono\\ NF:h12#e-subpixelantialias,Noto\\ Color\\ Emoji:h12")
    vim.g.neovide_scale_factor = 0.97
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
end
vim.cmd(':set background=dark')
vim.cmd(':set mousemoveevent')
vim.cmd([[autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]])
vim.g.everforest_enable_italic = 0
vim.g.everforest_background = 'hard'
vim.g.everforest_better_performance = 1
vim.g.everforest_ui_contrast = "low"
-- vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_diagnostic_virtual_text = 'colored'
vim.g.everforest_diagnostic_text_highlight = 1
-- vim.g.everforest_colors_override = {purple = {'#e28afa', '167'}}
-- vim.g.everforest_colors_override = {purple = {'#d6608f', '230'}}
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.cmd(":colorscheme everforest")
vim.cmd(":colorscheme kanagawa")


