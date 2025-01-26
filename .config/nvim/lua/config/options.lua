local opt = vim.opt
local g = vim.g

opt.termguicolors = true
opt.number = true

opt.mmp = 2000000
opt.runtimepath:append("~/current_course")

g.tex_flavor = "latex"
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.cmd("source ~/theme/nvim.vim")
