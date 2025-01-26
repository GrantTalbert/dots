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
local del = "[["

return {
	s(
		{ trig = "([%a]+)new", regTrig = true },
		fmta(
		[[
			s(
				{ trig = "<>", snippetType = "autosnippet"<> },
				fmta(<>
				<>
				<>,
				{
					<>
				}),
				{ <> }
			),
			<>
		]],
		{
			i(1), f( function(_, snip)
				if string.find(snip.captures[1], 'r') then
					if string.find(snip.captures[1], 'w') then
						return ", regTrig = true"
					else
						return ", regTrig = true, wordTrig = false"
					end
				elseif string.find(snip.captures[1], 'w') then
					if string.find(snip.captures[1], 'e') then
						return ", trigEngine = \"ecma\""
					else
						return ""
					end
				elseif string.find(snip.captures[1], 'e') then
					return ", wordTrig = false, trigEngine = \"ecma\""
				else
					return ", wordTrig = false"
				end
			end ),
			f( function(_, snip) return "[[" end), i(2), f( function(_, snip) return "]]" end), i(3), f( function(_, snip)
			if string.find(snip.captures[1], 'm') then
				if string.find(snip.captures[1], 'b') then
					return "condition = b and math_mode"
				else
					return "condition = math_mode"
				end
			elseif string.find(snip.captures[1], 'b') then
				return "condition = b"
			else
				return ""
			end
		end ), i(0)
		}
		),
		{ condition = b }
	),
	s(
		{ trig = "([%a]+)pfix", regTrig = true },
		fmta(
		[[
			postfix(
				{ trig = "<>", snippetType = "autosnippet"<> },
				{ f(function(_, snip)
					return "<>" .. snip.snippet.env.POSTFIX_MATCH .. "} "
				end) },
				{ <> }
			),
			<>
		]],
		{
			i(1), f( function(_, snip)
				if string.find(snip.captures[1], 'r') then
					if string.find(snip.captures[1], 'w') then
						return ", regTrig = true"
					else
						return ", regTrig = true, wordTrig = false"
					end
				elseif string.find(snip.captures[1], 'w') then
					if string.find(snip.captures[1], 'e') then
						return ", trigEngine = \"ecma\""
					else
						return ""
					end
				elseif string.find(snip.captures[1], 'e') then
					return ", wordTrig = false, trigEngine = \"ecma\""
				else
					return ", wordTrig = false"
				end
			end ),
			i(2), f( function(_, snip)
			if string.find(snip.captures[1], 'm') then
				if string.find(snip.captures[1], 'b') then
					return "condition = b and math_mode"
				else
					return "condition = math_mode"
				end
			elseif string.find(snip.captures[1], 'b') then
				return "condition = b"
			else
				return ""
			end
		end ), i(0)
		}
		),
		{ condition = b }
	)
}
