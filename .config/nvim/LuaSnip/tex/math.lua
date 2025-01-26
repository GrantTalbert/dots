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

local function get_matrix_env(letter)
	if letter == "p" then
		return "\\begin{pmatrix}", "\\end{pmatrix}"
	elseif letter == "b" then
		return "\\begin{bmatrix}", "\\end{bmatrix}"
	elseif letter == "B" then
		return "\\begin{Bmatrix}", "\\end{Bmatrix}"
	elseif letter == "v" then
		return "\\begin{vmatrix}", "\\end{vmatrix}"
	elseif letter == "V" then
		return "\\begin{Vmatrix}", "\\end{Vmatrix}"
	end
	return "\\begin{matrix}", "\\end{matrix}"
end


return {
-- MATH ENVIRONMENTS --
-- display math
s(
	{ trig = "dm", snippetType = "autosnippet" },
	fmta([[
	\[
		<>
	.\]
	<>
	]],
	{ i(1), i(0) }
	),
	{ condition = b }
),
-- inline math
s(
	{ trig = "fm", snippetType = "autosnippet" },
	{
		t("$"), i(1), t("$")
	},
	{ }
),
-- equation environment w/ label
s(
	{ trig = "sm", snippetType = "autosnippet" },
	fmta([[
	\begin{equation}\label{eq:<>}
		<>
	\end{equation}
	<>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = b }
),
-- commutative diagram
s(
	{ trig = "cm", snippetType = "autosnippet" },
	fmta([[
	\[\begin{tikzcd}[row sep = <>em, column sep = <>em]
		<>
	\end{tikzcd}\]
	<>
	]],
	{
		i(1, "2.5"), i(2, "2.5"), i(3), i(0)
	}),
	{ condition = b }
),
-- align
s(
	{ trig = "align", snippetType = "autosnippet" },
	fmta([[
	\begin{align*}
		<>
	.\end{align*}
	<>
	]],
	{
		i(1), i(0)
	}),
	{ condition = b }
),

-- matrices
s(
	{ trig = "([pbBvV])mat(%d+) (%d+)", snippetType = "autosnippet", regTrig = true, hidden = true, wordTrig = false },
	d(1, function(_, snip)
		local mat_type = snip.captures[1]
		local rows = tonumber(snip.captures[2]) or 2
		local cols = tonumber(snip.captures[3]) or 2

		local begin_env, end_env = get_matrix_env(mat_type)

		local nodes = {}
		table.insert(nodes, t({ begin_env, "" }))
		local insert_index = 1
		for r = 1, rows do
			for c = 1, cols do
				table.insert(nodes, i(insert_index))
				insert_index = insert_index + 1

				if c < cols then
					table.insert(nodes, t(" & "))
				end
			end

			if r < rows then
				table.insert(nodes, t({ " \\\\", "" }))
			else
				table.insert(nodes, t({ "", ""}))
			end
		end

		table.insert(nodes, t(end_env))

		return sn(nil, nodes)
	end)
),
-- various commands
s(
	{ trig = "...", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\ldots <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "~>", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\rightsquigglearrow <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "s.t.", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\text{ s.t. } <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "=>", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\implies <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "=<", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\impliedby <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "iff", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\iff <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
-- fractions --
s(
	{ trig = "//", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\frac{<>}{<>} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
-- this one is a heavy work in progress, tldr x/ doesnt work u have to do (x)/
s(
	{ trig = '(%d*?[A-Za-z]+)/', snippetType = "autosnippet", regTrig = true, wordTrig = false, priority = 1200 },
	{
		f(function(_, snip)
			local numerator = snip.captures[1] or ""
			return "\\frac{" .. snip.captures[1] .. "}{"
		end, {}), i(1), t("}"), i(0)
	},
	{ condition = math_mode }
),
s(
	{ trig = "^.*%)/", snippetType = "autosnippet", regTrig = true, wordTrig = false, priority = 1500 },
	{
		f(function(_, snip)
			local stripped = snip.trigger:sub(1, -2)
			local depth = 0
			local idx = #stripped
			while idx >= 1 do
				local c = stripped:sub(idx, idx)
				if c == ")" then
					depth = depth + 1
				elseif c == "(" then
					depth = depth - 1
				end
				if depth == 0 then
					break
				end
				idx = idx - 1
			end

			if idx < 1 then
				return stripped
			end

			local before = stripped:sub(1, idx - 1)
			local inside = stripped:sub(idx + 1, #stripped - 1)

			return before .. "\\frac{" .. inside .. "}"
		end, {}), t("{"), i(1), t("} "), i(0)
	},
	{ condition = math_mode }
),
-- auto subscript
s(
	{ trig = "([A-Za-z])_(%d%d)", snippetType = "autosnippet", regTrig = true },
	{
		f(function(_, snip)
			return snip.captures[1] .. "_{" .. snip.captures[2] .. "} "
		end), i(0)
	},
	{ condition = math_mode }
),
s(
	{ trig = "==", snippetType = "autosnippet"},
	fmta([[
	\equiv <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "!=", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\neq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "neq", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\neq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ceil", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left\lceil <> \right\rceil <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "flr", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left\lfloor <> \right\rfloor <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "()", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left( <> \right ) <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lrd", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left( <> \right) <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "abs", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left| <> \right| <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lra", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left\{ <> \right\} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lrb", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left[ <> \right] <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lr,", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left\langle <> \right\rangle <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lr.", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\left\langle <> \right\rangle <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "[nN]orm", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\left\| <> \right\| <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "conj", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^* <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(^|[^\\])()sum", snippetType = "autosnippet", regTrig = true },
	{
		f(function(_, snip)
			return snip.captures[1] or ""
		end), t("\\sum_{"), i(1, "i"), t("} "), i(0)
	},
	{ condition = math_mode }
),
s(
	{ trig = "Sum", snippetType = "autosnippet" },
	fmta([[
	\sum_{<>=<>}^{<>} <>
	]],
	{
		i(1, "i"), i(2, "0"), i(3, "\\infty"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lim", snippetType = "autosnippet" },
	fmta([[
	\lim_{<> \to <>} <>
	]],
	{
		i(1, "n"), i(2, "\\infty"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "lsup", snippetType = "autosnippet", priority = 1200 },
	fmta([[
	\limsup_{<> \to <>} <>
	]],
	{
		i(1, "n"), i(2, "\\infty"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "linf", snippetType = "autosnippet", priority = 1200 },
	fmta([[
	\liminf_{<> \to <>} <>
	]],
	{
		i(1, "n"), i(2, "\\infty"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "prd", snippetType = "autosnippet" },
	fmta([[
	\prod_{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "prod", snippetType = "autosnippet" },
	fmta([[
	\prod_{<>=<>}^{<>} <>
	]],
	{
		i(1, "n"), i(2, "1"), i(3, "\\infty"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "pt", snippetType = "autosnippet" },
	fmta([[
	\partial <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "pdif", snippetType = "autosnippet", priority = 1200 },
	fmta([[
	\frac{\partial <>}{\partial <>} <>
	]],
	{
		i(1, "f"), i(2, "x"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "dif", snippetType = "autosnippet" },
	fmta([[
	\frac{\mathrm{d}<>}{\mathrm{d}<>} <>
	]],
	{
		i(1, "y"), i(2, "x"), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "sq", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\sqrt{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "cbrt", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\sqrt[<>]{<>} <>
	]],
	{
		i(1, "3"), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "td", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "rd", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^{(<>)} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "__", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	_{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ooo", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\infty <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ">=", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\geq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "geq", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\geq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "<=", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\leq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "leq", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\leq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "EE", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\exists <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "AA", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\forall <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "R0+", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mathbb{R}_0^+ <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "([a-zA-Z])[cC]al", snippetType = "autosnippet", regTrig = true, wordTrig = false, priority = 1200 },
	fmta([[
	\mathcal{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1]:upper() end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(%w+)[bB]f", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\mathbf{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "rm", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mathrm{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "([a-zA-Z])[sS]cr", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\mathscr{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1]:upper() end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "fk", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mathfrak{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(\\\\)([a-zA-Z])", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\mathbb{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[2]:upper() end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(%w+)[sS]f", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\mathsf{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "op.", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\oplus <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ox.", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\otimes <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "x.", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\times <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ".x", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\times <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "**", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\cdot <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "blt", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\bullet <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(sin|cos|tan|cot|csc|sec|ln|log|exp|perp|inf|sup|Tr|diag|rank|det|dim|ker|Im|Re|min|max|sgn|im|land|lor)", snippetType = "autosnippet", trigEngine = "ecma" },
	{ f(function(_, snip) return '\\' .. snip.captures[1] .. " " end) },
	{ condition = math_mode }
),
s(
	{ trig = "a(sin|cos|tan|cot|csc|sec)", snippetType = "autosnippet", trigEngine = "ecma", priority = 1200 },
	fmta([[
	\arc<> <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "coker", snippetType = "autosnippet", wordTrig = false, priority = 1500 },
	fmta([[
	\coker <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "a(max|min)", snippetType = "autosnippet", trigEngine = "ecma" },
	fmta([[
	\arg<>_{<>} <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "tint", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\iiint\limits_{<>} <> \,\mathrm{d} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "dint", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\iint\limits_{<>} <> \,\mathrm{d} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "int", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\int <> \,\mathrm{d} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "oint", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\oint_{<>} <> \,\mathrm{d} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Tint", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\int_{<>}^{<>}\int_{<>}^{<>}\int_{<>}^{<>} <> \,\mathrm{d} <> \mathrm{d} <> \mathrm{d} <>
	]],
	{
		i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Dint", snippetType = "autosnippet", wordTrig = false, priority = 1200 },
	fmta([[
	\int_{<>}^{<>}\int_{<>}^{<>} <> \,\mathrm{d} <> \mathrm{d} <>
	]],
	{
		i(1), i(2), i(3), i(4), i(5), i(6), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Int", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\int_{<>}^{<>} <> \,\mathrm{d} <>
	]],
	{
		i(1), i(2), i(3), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "->", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\to <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "!>", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mapsto <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "inv", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^{-1} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "compl", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	^{c} <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "--", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\setminus <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ">>", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\gg <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "<<", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\ll <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "||", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mid <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "sub ", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\subset <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "sube", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\subseteq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "subn", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\subsetneq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "nin", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\notin <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "scup", snippetType = "autosnippet", wordTrig = false, priority = 1100 },
	fmta([[
	\sqcup <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "cup", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\cup <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Cup", snippetType = "autosnippet" },
	fmta([[
	\bigcup_{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "cap", snippetType = "autosnippet" },
	fmta([[
	\cap <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "Cap", snippetType = "autosnippet" },
	fmta([[
	\bigcap_{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ems", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\varnothing <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "tg", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\lhd <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "tet", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\text{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "fun", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	<> \to <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "([a-zA-Z])fun", snippetType = "autosnippet", regTrig = true, wordTrig = false, priority = 1200 },
	fmta([[
	<> : <> \to <>
	]],
	{
		f(function(_, snip) return snip.captures[1] end), i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "[bB]ar", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	fmta([[
	\overline{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
postfix(
	{ trig = "bar", snippetType = "autosnippet", priority = 1200 },
	{ f(function(_, snip)
		return "\\overline{" .. snip.snippet.env.POSTFIX_MATCH .. "} "
	end, {})},
	{ condition = math_mode }
),
s(
	{ trig = "tld", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\widetilde{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
postfix(
	{ trig = "tld", snippetType = "autosnippet", wordTrig = false, priority = 1500 },
	{ f(function(_, snip)
		return "\\widetilde{" .. snip.snippet.env.POSTFIX_MATCH .. "} "
	end) },
	{ condition = math_mode }
),
postfix(
	{ trig = "hat", snippetType = "autosnippet", wordTrig = false, priority = 1500 },
	{ f(function(_, snip)
		return "\\hat{" .. snip.snippet.env.POSTFIX_MATCH .. "} "
	end) },
	{ condition = math_mode }
),
postfix(
	{ trig = ",.", snippetType = "autosnippet", wordTrig = false, priority = 1500 },
	{ f(function(_, snip)
		return "\\vec{" .. snip.snippet.env.POSTFIX_MATCH .. "} "
	end) },
	{ condition = math_mode }
),
postfix(
	{ trig = ".,", snippetType = "autosnippet", wordTrig = false, priority = 1500 },
	{ f(function(_, snip)
		return "\\vec{" .. snip.snippet.env.POSTFIX_MATCH .. "} "
	end) },
	{ condition = math_mode }
),
s(
	{ trig = "opn", snippetType = "autosnippet" },
	fmta([[
	\operatorname{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "(~=|cong|iso)", snippetType = "autosnippet", wordTrig = false, trigEngine = "ecma" },
	fmta([[
	\cong <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "~-", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\simeq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "cir", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\circ <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "@>", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\hookrightarrow <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "1..n", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	<>_1, \ldots, <>_n <>
	]],
	{
		i(1), rep(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "dot", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\dot{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "ind", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\mathbbm{1}_{<>} <>
	]],
	{
		i(1), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "sim", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\sim <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "apx", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\approx <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "binom", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\binom{<>}{<>} <>
	]],
	{
		i(1), i(2), i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = ":=", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\coloneqq <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "=:", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\eqqcolon <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
),
s(
	{ trig = "tsim", snippetType = "autosnippet", wordTrig = false },
	fmta([[
	\tildesim <>
	]],
	{
		i(0)
	}),
	{ condition = math_mode }
)
}
