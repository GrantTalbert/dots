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
local postfix = require("luasnip.extras.postfix").postfix

local math_mode = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
return {
s(
	{ trig = "(;a|alpha)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\alpha <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":a", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\alpha} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;b|beta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\beta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":b", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\beta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;g|gamma)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\gamma <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;G|Gamma)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Gamma <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":g", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\gamma} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":G", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Gamma} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;d|delta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\delta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;D|Delta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Delta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":d", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\delta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":D", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Delta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "eps", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\epsilon <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ";ve", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\varepsilon <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "::e", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\boldsymbol{\epsilon} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":ve", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\varepsilon} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;z|zeta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\zeta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":z", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\zeta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;e|eta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\eta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":e", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\eta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;t|theta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\theta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;T|Theta)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Theta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ";vt", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\vartheta <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":t", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\theta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":T", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Theta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":vt", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\vartheta} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;i|iota)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\iota <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":i", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\iota} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;k|kappa)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\kappa <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":k", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\kappa} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;l|lambda)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\lambda <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;L|Lambda)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Lambda <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":l", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\lambda} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":L", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Lambda} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;m|mu)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\mu <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":m", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\mu} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;n|nu)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\nu <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":n", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\nu} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;n|nabla)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma", priority = 1100 },
	fmta([[
	\nabla <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;x|xi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\xi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;X|Xi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Xi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":x", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\xi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":X", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Xi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;p|pi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\pi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;P|Pi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Pi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":p", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\pi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":P", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Pi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;r|rho)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\rho <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":r", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\rho} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;s|sigma)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\sigma <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;S|Sigma)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Sigma <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":s", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\sigma} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":S", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Sigma} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;t|tau)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma", priority = 1100 },
	fmta([[
	\tau <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "::t", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\boldsymbol{\tau} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;u|upsilon)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\upsilon <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;U|Upsilon)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Upsilon <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":u", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\upsilon} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":U", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Upsilon} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;p|phi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma", priority = 1100 },
	fmta([[
	\phi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;P|Phi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma",  priority = 1100 },
	fmta([[
	\Phi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "::p", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\boldsymbol{\phi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "::P", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\boldsymbol{\Phi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;c|chi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\chi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":c", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\chi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;;p|psi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma", priority = 1200 },
	fmta([[
	\psi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;;;P|Psi)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma", priority = 1200 },
	fmta([[
	\Psi <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":::p", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\boldsymbol{\psi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":::P", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\boldsymbol{\Psi} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;o|omega)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\omega <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(;O|Omega)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\Omega <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":o", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\omega} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":O", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\boldsymbol{\Omega} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ell", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\ell <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
)
}
