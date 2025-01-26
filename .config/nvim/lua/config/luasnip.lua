local ls =  require("luasnip")

ls.config.set_config({
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

-- keymaps

local set = vim.keymap.set
local opts = { silent = true }

set("i", "<Tab>", function() ls.expand() end, opts)
set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, opts)
set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, opts)
set({ "i", "s" }, "<Tab>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)
