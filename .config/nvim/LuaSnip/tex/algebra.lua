local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local b = require("luasnip.extras.conditions.expand").line_begin
local events = require("luasnip.util.events")

local math_mode = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
s(
	{ trig = "rmod", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\Rmod{<>} <>
	]],
	{
		i(1, "R"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "vect", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\Vect{<>} <>
	]],
	{
		i(1, "k"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "hom", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\Hom_{<>}(<>, <>) <>
	]],
	{
		i(1), i(2), i(3), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Hom", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\Hom(<>, <>) <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "end", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\End_{<>}(<>) <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "End", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\End(<>) <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "aut", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\Aut_{<>}(<>) <>
	]],
	{
		i(1), i(2), i(3)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Aut", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\Aut(<>) <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "[oO]bj", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\Obj(<>) <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
)
}
