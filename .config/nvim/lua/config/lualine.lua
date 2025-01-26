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
