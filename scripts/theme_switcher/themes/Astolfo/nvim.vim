
" tex
hi texStatement guifg=#5fd7ff gui=bold
" i dont know what these are actually
hi texCmdEnv guifg=#87d7ff gui=bold
" commands in regular text
hi texCmd guifg=#00ffff
" some math commands like greeks map to this
hi texEnvArgName guifg=#5f5fff gui=italic
" \begin{texEnvArgName}
hi texMathZone guifg=#00afff
" math text font
hi texSection guifg=#5f5fff gui=bold
" idfk
hi texMathDelim guifg=#0087ff
" math deliminers
hi texComment guifg=#5f5fff gui=italic
" comments
hi texSpecialChar guifg=#87d7ff
" special characters like \@
hi texMathSymbol guifg=#5fd7ff
" standard math env commands like \times
hi texAuthorArg guifg=#87d7ff
" \author argument
hi texTitleArg guifg=#87d7ff gui=underline
" \title argument
hi texStyleBold gui=bold
" bold text
hi texStyleItal gui=italic
" italic text
hi texDelim guifg=#00afff
" curly braces in stuff like \section{...} and also math environment wrappers
hi texPartArgTitle guifg=#5fd7ff gui=bold
" stuff inside \section headers

" py
hi pythonStatement guifg=#ffff00
hi pythonConditional guifg=#ffff00 gui=bold
hi pythonException guifg=#ffff00 gui=bold
hi pythonInclude guifg=#00afff
hi pythonMatrixMultiply guifg=#d75f5f
hi pythonString guifg=#ff00ff
hi pythonFunction guifg=#00ffff
hi pythonRawString guifg=#ff00ff
hi pythonNumber guifg=#ff00ff
hi pythonBuiltIn guifg=#00ffff
hi pythonExceptions guifg=#ffff00
hi pythonRepeat guifg=#ffff00


" idk
hi StatusLine    guibg=#00005f guifg=#ffffff
hi VertSplit     guibg=#00005f guifg=#00005f
hi Visual        guibg=#005faf
hi SpecialKey guifg=#00afff
hi Special guifg=#00afff


" general
hi Operator	guifg=#ffff00
hi LineNr	guifg=#5fd7ff
hi CursorLineNr	guifg=#5fd7ff
hi Comment	guifg=#808080
hi Constant	guifg=#00ffff
hi Identifier	guifg=#00c0c0
hi Statement	guifg=#c0c000
hi PreProc	guifg=#0000ff
hi Type		guifg=#d75f5f
hi Error	guifg=#ffffff guibg=#ff0000
hi Todo		guifg=#000000 guibg=#c0c000

