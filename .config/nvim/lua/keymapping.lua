vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

-- page up/down
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- split
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)
map("n", "so", "<C-w>o", opt) -- close others

-- 比例控制（不常用，因为支持鼠标拖拽）
map("n", "s>", ":vertical resize +20<CR>", opt)
map("n", "s<", ":vertical resize -20<CR>", opt)
map("n", "s=", "<C-w>=", opt)
map("n", "sj", ":resize +10<CR>",opt)
map("n", "sk", ":resize -10<CR>",opt)

-- switch window
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- My keys
map("i", "<C-a>", "<ESC>I", opt)
map("n", "<C-e>", "<ESC>$", opt)
map("i", "<C-e>", "<ESC>A", opt)
-- map("t", "<C-S-C>", '<ESC>', {buffer = 0})

--Plug
-- nvimTree
map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)
-- tagbar
map('n', '<A-t>', ':SymbolsOutline<CR>', opt)
-- trouble
map('n', '<A-d>', ':TroubleToggle<CR>', opt)

-- bufferline 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- Tresitter node action
vim.keymap.set({ "n" }, "<C-n>", require("ts-node-action").node_action, { desc = "Trigger Node Action" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'F', builtin.find_files, opt)
vim.keymap.set('n', 'Y', builtin.live_grep, opt)
vim.keymap.set('n', 'T', builtin.oldfiles, opt)


if vim.g.neovide then
    map("i", "<C-S-C>", '<ESC>"+yA', opt)
    map("n", "<C-S-C>", '"+y', opt)
    map("v", "<C-S-C>", '"+y', opt)
    map("c", "<C-S-C>", '"+y', opt)

    map("i", "<C-S-V>", '<ESC>"+pA', opt)
    map("n", "<C-S-V>", '"+p', opt)
    map("v", "<C-S-V>", '"+p', opt)
    map("c", "<C-S-V>", '"+p', opt)
end

