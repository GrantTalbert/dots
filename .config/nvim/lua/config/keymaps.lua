local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<C-s>", ":w<CR>:VimtexCompileSS<CR>", opts)
set("i", "<C-s>", "<C-o>:w<CR><C-o>:VimtexCompileSS<CR>", opts)
set("v", "<C-s>", "<Esc>:w<CR><Esc>:VimtexCompileSS<CR>", opts)
set("i", "<C-z>", "<C-o>:u<CR>", opts)
