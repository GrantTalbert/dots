call plug#begin()

set termguicolors

Plug 'lilydjwg/colorizer'
Plug 'andweeb/presence.nvim'

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsDirectories=["UltiSnips", "snippets"]

Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

noremap <C-s> :w<CR>:VimtexCompileSS<CR>
inoremap <C-s> <c-o>:w<CR><c-o>:VimtexCompileSS<CR>
vnoremap <C-s> <Esc>:w<CR><Esc>:VimtexCompileSS<CR>
inoremap <C-z> <c-o>:u<CR>
noremap <F2> :w<CR>:!~/scripts/University/comp.sh<CR>
inoremap <F2> <C-o>:w<CR><C-o>:!~/scripts/University/comp.sh<CR>
vnoremap <F2> <Esc>:w<CR>:!~/scripts/University/comp.sh<CR>

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require'luasnip'.jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

"Plug 'rafi/awesome-vim-colorschemes'
"set background=dark

syntax enable

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'morhetz/gruvbox'

call plug#end()

hi Normal guibg=NONE
source ~/theme/nvim.vim
set mmp=2000000
set number

lua << EOF


require("luasnip").config.set_config({
	enable_autosnips = true,
	store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip"})

local colors = {
	darkgray = "#121212",
	gray = "#727169",
	innerbg = nil,
	outerbg = "#121212",
	normal = "#008FFF",
	insert = "#00FFFF",
	visual = "#e46876",
	replace = "#e46876",
	command = "#00FF99",
}
local my_theme = {
	inactive = {
		a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	visual = {
		a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	replace = {
		a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	normal = {
		a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	insert = {
		a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
	command = {
		a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
		b = { fg = colors.gray, bg = colors.outerbg },
		c = { fg = colors.gray, bg = colors.innerbg },
	},
}
require('lualine').setup{
	options = {
		theme = my_theme,
		component_separators = " ",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
}
EOF
