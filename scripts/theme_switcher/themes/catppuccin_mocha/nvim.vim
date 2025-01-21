" tex
hi texCmdEnv guifg=#89dceb gui=bold
" commands in regular text
hi texCmd guifg=#89dceb
" some math commands like greeks map to this
hi texEnvArgName guifg=#89b4fa gui=italic
" \begin{texEnvArgName}
hi texMathZone guifg=#cba6f7
" math text font
hi texSection guifg=#bac2de gui=bold
" idfk
hi texMathDelim guifg=#eba0ac
" math deliminers
hi texComment guifg=#9399b2 gui=italic
" comments
hi texSpecialChar guifg=#f5c2e7
" special characters like \@
hi texMathSymbol guifg=#83dceb
" standard math env commands like \times
hi texAuthorArg guifg=#cdd6f4
" \author argument
hi texTitleArg guifg=#cdd6f4 gui=underline
" \title argument
hi texStyleBold gui=bold
" bold text
hi texStyleItal gui=italic
" italic text
hi texDelim guifg=#74c7ec
" curly braces in stuff like \section{...} and also math environment wrappers
hi texPartArgTitle guifg=#bac2de gui=bold
" stuff inside \section headers

" py
hi pythonStatement guifg=#f9e2af
hi pythonConditional guifg=#f9e2af gui=bold
hi pythonException guifg=#f9e2af gui=bold
hi pythonInclude guifg=#f9e2af
hi pythonString guifg=#a6e3a1
hi pythonFunction guifg=#89b4fa
hi pythonRawString guifg=#a6e3a1
hi pythonNumber guifg=#fab387
hi pythonBuiltIn guifg=#f38ba8
hi pythonExceptions guifg=#f9e2af
hi pythonRepeat guifg=#f9e2af
hi pythonEscape guifg=#f5c2e7
hi pythonBuiltin guifg=#f38ba8


" idk
hi StatusLine    guibg=#00005f guifg=#ffffff
hi VertSplit     guibg=#00005f guifg=#00005f
hi Visual        guibg=#005faf
hi SpecialKey guifg=#00afff
hi Special guifg=#00afff


" general
hi Normal	guifg=#ffffff
hi Constant	guifg=#fab387
hi Number	guifg=#fab387
hi String	guifg=#a6e3a1
hi Keyword	guifg=#cba6f7
hi Conditional	guifg=#cba6f7
hi Repeat	guifg=#cba6f7
hi Comment	guifg=#9399b2
hi Operator	guifg=#89dceb
hi Delimiter	guifg=#9399b2
hi Function	guifg=#89b4fa
hi Type		guifg=#f9e2af
hi Typedef	guifg=#f9e2af
hi LineNr	guifg=#5fd7ff
hi CursorLineNr	guifg=#5fd7ff
hi Identifier	guifg=#eba0ac
hi Statement	guifg=#cba6f7
hi Error	guifg=#ffffff guibg=#f38ba8
hi Todo		guifg=#000000 guibg=#c0c000

lua << EOF


vim.cmd.colorscheme "catppuccin-mocha"

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = false,
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percenntage = 0.15,
	},
	no_italic = false,
	no_bold = false,
	no_underline = false,
	styles = {
		comments = { "italic" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		miscs = {},
	},
	color_overrides = {},
	custom_highlighs = {},
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	},
})
