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
local fmt = require("luasnip.extras.fmt").fmt

local rec_item
rec_item = function()
	return sn(nil, {
		t({"", "\t\\item "}),
		i(1),
		d(2, rec_item, {}),
	})
end

local math_mode = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
return {
s(
	{ trig = "beg", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{<>}
		<>
	\end{<>}
	<>
	]],
	{
		i(1), i(2), i(3), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "fig", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{figure}[<>]
		\includegraphics[width=<>]{<>}
		\caption{<>}
		\label{fig:<>}
		\centering
	\end{figure}
	<>
	]],
	{
		i(1, "ht"), i(2, "0.5"), i(3), i(4), i(5), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "enum", snippetType = "autosnippet", wordTrig = false },
	{
		t("\\begin{enumerate}"),
		d(1, rec_item, {}),
		t({"", "\\end{enumerate}"}),
		i(0)
	},
	{ condition = b }
),
s(
	{ trig = "item", snippetType = "autosnippet", wordTrig = false },
	{
		t("\\begin{itemize}"),
		d(1, rec_item, {}),
		t({"", "\\end{itemize}"}),
		i(0)
	},
	{ condition = b }
),
s(
	{ trig = "(%w+)[bB]f", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\textbf{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(0)
	}),
	{  }
),
s(
	{ trig = "emph", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\emph{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{  }
),
s(
	{ trig = "atf", snippetType = "autosnippet" },
	fmta([[
	\autoref{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{  }
),
s(
	{ trig = "hpr", snippetType = "autosnippet" },
	fmta([[
	\hyperref[<>]{<>} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{  }
),
s(
	{ trig = "lbl", snippetType = "autosnippet" },
	fmta([[
	\label{<>}
	]],
	{
		i(0)
	}),
	{  }
),
s(
	{ trig = "dfn", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{definition}[<>]{dfn:<>}
		<>
	\end{definition}
	<>
	]],
	{
		i(1), i(2), i(3), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "thm", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{theorem}[<>]{thm:<>}
		<>
	\end{theorem}
	<>
	]],
	{
		i(1), i(2), i(3), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "prp", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{proposition}{prp:<>}
		<>
	\end{proposition}
	<>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "lma", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{lemma}{lma:<>}
		<>
	\end{lemma}
	<>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "cor", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{corollary}{cor:<>}
		<>
	\end{corollary}
	<>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = b }
),
s(
	{ trig = "prf", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\begin{proof}
		<>
	\end{proof}
	<>
	]],
	{
		i(1), i(0)
	}),
	{ condition = b }
)
}
