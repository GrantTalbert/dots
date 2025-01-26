return require("lazy").setup({
	{ -- colorizer
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end
	},
	{ -- snippets
		"L3MON4D3/LuaSnip",
		version = "2.3.0",
		build = "make install_jsregexp",
		config = function()
			require("config.luasnip")
		end,
	},
	{ -- vimtex
		"lervag/vimtex",
		ft = { "tex", "plaintex" },
		config = function()
		end,
	},
	{ -- lualine
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},
	{ -- colorschemes
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000
	},
	{
		"morhetz/gruvbox",
		lazy = true
	}
})
