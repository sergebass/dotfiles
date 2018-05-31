""" --------------
""" THEME SETTINGS
""" --------------

let g:colors_name = "sergebass-dark"

set background=dark

if exists("syntax_on")
  syntax reset
endif

hi clear

hi Normal term=none cterm=none ctermfg=250 ctermbg=234 gui=none guifg=#c0c0c0 guibg=#002020

" FIXME temporary highlighting placeholders, taken from vim documentation;
" uncomment and fix.
"
" Conceal     placeholder characters substituted for concealed text (see 'conceallevel')
"
" FoldColumn  'foldcolumn'
" SignColumn  column where |signs| are displayed
"
" SpellBad    Word that is not recognized by the spellchecker. |spell|
"         This will be combined with the highlighting used otherwise.
" SpellCap    Word that should start with a capital. |spell|
"         This will be combined with the highlighting used otherwise.
" SpellLocal  Word that is recognized by the spellchecker as one that is
"         used in another region. |spell|
"         This will be combined with the highlighting used otherwise.
" SpellRare   Word that is recognized by the spellchecker as one that is
"         hardly ever used. |spell|
"         This will be combined with the highlighting used otherwise.
"
" Title       titles for output from ":set all", ":autocmd" etc.
" VisualNOS   Visual mode selection when vim is "Not Owning the Selection".
"         Only X11 Gui's |gui-x11| and |xterm-clipboard| supports this.

hi Cursor term=none cterm=none ctermfg=0 ctermbg=214 gui=bold guifg=black guibg=#ffaf00
hi CursorIM term=none cterm=none ctermfg=0 ctermbg=201 gui=bold guifg=black guibg=#ff00ff
hi CursorLine term=underline cterm=none ctermbg=237 gui=none guibg=#404030
hi CursorColumn term=none cterm=none ctermbg=237 gui=none guibg=#404030
hi CursorLineNr term=bold cterm=bold ctermfg=246 ctermbg=0 gui=bold guifg=#949494 guibg=#000000
hi LineNr term=none cterm=none ctermfg=240 ctermbg=0 gui=none guifg=#606060 guibg=#000000

if has("nvim")
    hi TermCursor term=none cterm=none ctermfg=0 ctermbg=119 gui=bold guifg=black guibg=#87ff5f
    hi TermCursorNC term=none cterm=none ctermfg=0 ctermbg=197 gui=bold guifg=black guibg=#ff005f
endif

" line length limit highlighting
hi ColorColumn term=none cterm=none ctermbg=0 guibg=#301010

hi StatusLine term=reverse cterm=bold ctermfg=15 ctermbg=20 gui=bold guifg=#ffffff guibg=#0000b8
hi StatusLineNC term=reverse cterm=none ctermfg=15 ctermbg=17 gui=none guifg=#b2b2b2 guibg=#00005f

" change statusline colors depending on the current mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse cterm=bold ctermfg=15 ctermbg=22 gui=bold guifg=#ffffff guibg=#006000
  au InsertLeave * hi StatusLine term=reverse cterm=bold ctermfg=15 ctermbg=20 gui=bold guifg=#ffffff guibg=#0000b8
endif

hi TabLine term=reverse cterm=reverse ctermfg=19 ctermbg=255 gui=none guifg=#eeeeee guibg=#0000af
hi TabLineFill term=reverse cterm=reverse ctermfg=19 ctermbg=255 gui=none guifg=#eeeeee guibg=#0000af
hi TabLineSel term=reverse cterm=reverse,bold ctermfg=22 ctermbg=220 gui=bold guifg=#ffd700 guibg=#005f00

hi MoreMsg term=reverse cterm=reverse,bold ctermfg=19 ctermbg=15 gui=bold guifg=#ffffff guibg=#0000af
hi ModeMsg term=reverse cterm=reverse,bold ctermfg=22 ctermbg=226 gui=bold guifg=#ffff00 guibg=#005f00
hi ErrorMsg term=reverse cterm=reverse,bold ctermfg=88 ctermbg=226 gui=bold guifg=#ffff00 guibg=#870000
hi WarningMsg term=reverse cterm=reverse,bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00
hi Question term=reverse cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00

hi Search term=reverse cterm=reverse,bold ctermfg=24 ctermbg=226 gui=bold guifg=#ffff00 guibg=#005050
hi IncSearch term=reverse cterm=reverse,bold ctermfg=24 ctermbg=226 gui=bold guifg=#ffff00 guibg=#005050

hi Directory term=none cterm=none ctermfg=123 gui=none guifg=#87ffff

hi Visual term=reverse cterm=reverse,bold ctermfg=90 ctermbg=226 gui=bold guibg=#5f0087

hi NonText term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi EndOfBuffer term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi Ignore ctermfg=black guifg=bg
hi VertSplit term=reverse cterm=bold ctermfg=21 ctermbg=0 gui=bold guifg=#0000ff guibg=#000000
hi Folded term=reverse ctermfg=yellow ctermbg=238 guifg=Yellow guibg=#303030
hi MatchParen term=reverse cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050

" popup menus (autocompletion etc.)
hi Pmenu term=reverse cterm=none ctermfg=228 ctermbg=17 gui=none guifg=#ffff87 guibg=#00005f  " normal item
hi PmenuSel term=bold cterm=bold ctermfg=226 ctermbg=28 gui=bold guifg=#ffff00 guibg=#008700 " selected item
hi PmenuSbar term=none cterm=none ctermbg=21 gui=none guibg=#0000ff " scrollbar
hi PmenuThumb term=reverse cterm=none ctermbg=165 gui=none guibg=#d700ff " scrollbar thumb

hi WildMenu term=bold cterm=bold ctermfg=226 ctermbg=28 gui=bold guifg=#ffff00 guibg=#008700 " selected item

" show non-space whitespace using this coloring:
hi SpecialKey term=reverse cterm=none ctermfg=125 ctermbg=236 gui=none guifg=#af005f guibg=#303030

hi Special term=bold ctermfg=DarkMagenta guifg=Red
hi Comment term=none cterm=none ctermfg=105 gui=none guifg=#8787ff
hi SpecialComment term=bold cterm=bold ctermfg=105 gui=bold guifg=#8787ff
hi Constant term=underline cterm=none ctermfg=48 guifg=#00ff87
hi Identifier term=underline cterm=none ctermfg=Cyan guifg=#40ffff
hi Statement term=none ctermfg=50 gui=none guifg=#00ffd7
hi PreProc term=bold cterm=none ctermfg=159 gui=none guifg=#afffff
hi Type term=none cterm=none ctermfg=255 gui=none guifg=#eeeeee
hi Function term=bold cterm=bold gui=bold
hi StorageClass term=none cterm=none ctermfg=39 gui=none guifg=#00afff
hi Scope term=none cterm=none ctermfg=42 gui=none guifg=#00d787
hi Repeat term=underline ctermfg=White guifg=white
hi Operator term=none cterm=none ctermfg=195 gui=none guifg=#d7ffff
hi Error term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi Todo term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000

hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Conditional Statement
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link Debug Special

hi DiffAdd cterm=bold ctermfg=Yellow ctermbg=22 gui=bold guifg=Yellow guibg=#004000
hi DiffDelete cterm=bold ctermfg=Yellow ctermbg=88 gui=bold guifg=Yellow guibg=#400000
hi DiffChange cterm=bold ctermfg=Yellow ctermbg=18 gui=bold guifg=Yellow guibg=#000040
hi DiffText cterm=inverse ctermfg=Yellow ctermbg=18 gui=inverse guifg=Yellow guibg=#000040

" this is needed to make git commit respect our existing diff highlighting
hi link diffCommon Normal
hi link diffIdentical Normal
hi link diffAdded DiffAdd
hi link diffChanged DiffChange
hi link diffRemoved DiffDelete
hi link diffComment Comment

hi diffFile cterm=bold ctermfg=15 ctermbg=0 gui=bold guifg=#ffffff guibg=#000000
hi diffOldFile cterm=bold ctermfg=9 ctermbg=0 gui=bold guifg=#ff0000 guibg=#000000
hi diffNewFile cterm=bold ctermfg=10 ctermbg=0 gui=bold guifg=#00ff00 guibg=#000000

" FIXME check all these other hi settings:
" diffOnly       xxx links to Constant
" diffDiffer     xxx links to Constant
" diffBDiffer    xxx links to Constant
" diffIsA        xxx links to Constant
" diffNoEOL      xxx links to Constant
" diffSubname    xxx links to PreProc
" diffLine       xxx links to Statement
" diffIndexLine  xxx links to PreProc

hi link GitGutterAdd DiffAdd
hi link GitGutterDelete DiffDelete
hi link GitGutterChange DiffChange
hi link GitGutterChangeDelete DiffChange

" FIXME this is a full dump of current highlight groups taken with a loaded
" Java file; refactor and assign proper color values:

"BookmarkAnnotationLine xxx links to BookmarkAnnotationLineDefault
"BookmarkAnnotationLineDefault xxx ctermfg=232 ctermbg=28
"BookmarkAnnotationSign xxx links to BookmarkAnnotationSignDefault
"BookmarkAnnotationSignDefault xxx ctermfg=28
"BookmarkLine   xxx links to BookmarkLineDefault
"BookmarkLineDefault xxx ctermfg=232 ctermbg=33
"BookmarkSign   xxx links to BookmarkSignDefault
"BookmarkSignDefault xxx ctermfg=33
"Boolean        xxx links to Constant
"Character      xxx links to Constant
"ColorColumn    xxx ctermbg=234 guibg=#301010
"Comment        xxx cterm=bold,italic ctermfg=123 gui=bold,italic guifg=#87ffff
"Conceal        xxx ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
"Conditional    xxx links to Repeat
"Constant       xxx ctermfg=227 guifg=#ffff5f
"CtrlPBufferCur xxx links to Question
"CtrlPBufferCurMod xxx links to WarningMsg
"CtrlPBufferHid xxx links to Comment
"CtrlPBufferHidMod xxx links to String
"CtrlPBufferInd xxx links to Normal
"CtrlPBufferNr  xxx links to Constant
"CtrlPBufferPath xxx links to Comment
"CtrlPBufferVis xxx links to Normal
"CtrlPBufferVisMod xxx links to Identifier
"CtrlPLinePre   xxx ctermfg=0 guifg=0
"CtrlPMark      xxx links to Search
"CtrlPMatch     xxx links to Identifier
"CtrlPMode1     xxx links to Character
"CtrlPMode2     xxx links to LineNr
"CtrlPNoEntries xxx links to Error
"CtrlPPrtBase   xxx links to Comment
"CtrlPPrtCursor xxx links to Constant
"CtrlPPrtText   xxx links to Normal
"CtrlPStats     xxx links to Function
"Cursor         xxx cterm=bold ctermfg=0 ctermbg=214 gui=bold guifg=black guibg=#ffaf00
"CursorColumn   xxx ctermbg=236 guibg=#404030
"CursorIM       xxx cterm=bold ctermfg=0 ctermbg=201 gui=bold guifg=black guibg=#ff00ff
"CursorLine     xxx ctermbg=236 guibg=#404030
"CursorLineNr   xxx cterm=bold ctermfg=245 ctermbg=0 gui=bold guifg=#808080 guibg=#000000
"Debug          xxx links to Special
"Define         xxx links to PreProc
"Delimiter      xxx links to Special
"DiffAdd        xxx cterm=bold ctermfg=11 ctermbg=22 gui=bold guifg=Yellow guibg=#004000
"DiffChange     xxx cterm=bold ctermfg=11 ctermbg=18 gui=bold guifg=Yellow guibg=#000040
"DiffDelete     xxx cterm=bold ctermfg=11 ctermbg=88 gui=bold guifg=Yellow guibg=#400000
"DiffText       xxx cterm=reverse ctermfg=11 ctermbg=18 gui=reverse guifg=Yellow guibg=#000040
"EndOfBuffer    xxx ctermfg=240 guifg=#585858
"Error          xxx cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
"ErrorMsg       xxx cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
"Exception      xxx links to Statement
"Float          xxx links to Number
"FoldColumn     xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
"Folded         xxx ctermfg=11 ctermbg=238 guifg=Yellow guibg=#303030
"Function       xxx ctermfg=15 guifg=White

"GitGutterAdd   xxx links to DiffAdd
"GitGutterAddDefault xxx ctermfg=2 ctermbg=0 guifg=#009900 guibg=#000000
"GitGutterAddInvisible xxx ctermfg=0 ctermbg=0 guifg=bg guibg=#000000
"GitGutterAddLine xxx links to DiffAdd
"GitGutterChange xxx links to DiffChange
"GitGutterChangeDefault xxx ctermfg=3 ctermbg=0 guifg=#bbbb00 guibg=#000000
"GitGutterChangeDelete xxx links to DiffChange
"GitGutterChangeDeleteDefault xxx links to GitGutterChangeDefault
"GitGutterChangeDeleteInvisible xxx links to GitGutterChangeInvisible
"GitGutterChangeDeleteLine xxx links to GitGutterChangeLine
"GitGutterChangeInvisible xxx ctermfg=0 ctermbg=0 guifg=bg guibg=#000000
"GitGutterChangeLine xxx links to DiffChange
"GitGutterDelete xxx links to DiffDelete
"GitGutterDeleteDefault xxx ctermfg=1 ctermbg=0 guifg=#ff2222 guibg=#000000
"GitGutterDeleteInvisible xxx ctermfg=0 ctermbg=0 guifg=bg guibg=#000000
"GitGutterDeleteLine xxx links to DiffDelete

"Identifier     xxx ctermfg=14 guifg=#40ffff
"Ignore         xxx ctermfg=0 guifg=bg
"IncSearch      xxx cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050
"Include        xxx links to PreProc
"Keyword        xxx links to Statement
"Label          xxx links to Statement
"LineNr         xxx ctermfg=240 ctermbg=0 guifg=#606060 guibg=#000000
"Macro          xxx links to PreProc
"MatchParen     xxx cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050
"ModeMsg        xxx cterm=bold ctermfg=226 ctermbg=22 gui=bold guifg=#ffff00 guibg=#005f00
"MoreMsg        xxx cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
"MyWordHighlight xxx cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
"NoInParens     xxx cleared
"NonText        xxx ctermfg=240 guifg=#585858
"None           xxx cleared
"Normal         xxx ctermfg=250 ctermbg=0 guifg=#c0c0c0 guibg=#000000
"NormalNC       xxx cleared
"Number         xxx links to Constant

"NvimAnd        xxx links to NvimBinaryOperator
"NvimArrow      xxx links to Delimiter
"NvimAssignment xxx links to Operator
"NvimAssignmentWithAddition xxx links to NvimAugmentedAssignment
"NvimAssignmentWithConcatenation xxx links to NvimAugmentedAssignment
"NvimAssignmentWithSubtraction xxx links to NvimAugmentedAssignment
"NvimAugmentedAssignment xxx links to NvimAssignment
"NvimBinaryMinus xxx links to NvimBinaryOperator
"NvimBinaryOperator xxx links to NvimOperator
"NvimBinaryPlus xxx links to NvimBinaryOperator
"NvimCallingParenthesis xxx links to NvimParenthesis
"NvimColon      xxx links to Delimiter
"NvimComma      xxx links to Delimiter
"NvimComparison xxx links to NvimBinaryOperator
"NvimComparisonModifier xxx links to NvimComparison
"NvimConcat     xxx links to NvimBinaryOperator
"NvimConcatOrSubscript xxx links to NvimConcat
"NvimContainer  xxx links to NvimParenthesis
"NvimCurly      xxx links to NvimSubscript
"NvimDict       xxx links to NvimContainer
"NvimDivision   xxx links to NvimBinaryOperator
"NvimDoubleQuote xxx links to NvimStringQuote
"NvimDoubleQuotedBody xxx links to NvimStringBody
"NvimDoubleQuotedEscape xxx links to NvimStringSpecial
"NvimDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
"NvimEnvironmentName xxx links to NvimIdentifier
"NvimEnvironmentSigil xxx links to NvimOptionSigil
"NvimFigureBrace xxx links to NvimInternalError
"NvimFloat      xxx links to NvimNumber
"NvimIdentifier xxx links to Identifier
"NvimIdentifierKey xxx links to NvimIdentifier
"NvimIdentifierName xxx links to NvimIdentifier
"NvimIdentifierScope xxx links to NvimIdentifier
"NvimIdentifierScopeDelimiter xxx links to NvimIdentifier
"NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
"NvimInvalid    xxx links to Error
"NvimInvalidAnd xxx links to NvimInvalidBinaryOperator
"NvimInvalidArrow xxx links to NvimInvalidDelimiter
"NvimInvalidAssignment xxx links to NvimInvalid
"NvimInvalidAssignmentWithAddition xxx links to NvimInvalidAugmentedAssignment
"NvimInvalidAssignmentWithConcatenation xxx links to NvimInvalidAugmentedAssignment
"NvimInvalidAssignmentWithSubtraction xxx links to NvimInvalidAugmentedAssignment
"NvimInvalidAugmentedAssignment xxx links to NvimInvalidAssignment
"NvimInvalidBinaryMinus xxx links to NvimInvalidBinaryOperator
"NvimInvalidBinaryOperator xxx links to NvimInvalidOperator
"NvimInvalidBinaryPlus xxx links to NvimInvalidBinaryOperator
"NvimInvalidCallingParenthesis xxx links to NvimInvalidParenthesis
"NvimInvalidColon xxx links to NvimInvalidDelimiter
"NvimInvalidComma xxx links to NvimInvalidDelimiter
"NvimInvalidComparison xxx links to NvimInvalidBinaryOperator
"NvimInvalidComparisonModifier xxx links to NvimInvalidComparison
"NvimInvalidConcat xxx links to NvimInvalidBinaryOperator
"NvimInvalidConcatOrSubscript xxx links to NvimInvalidConcat
"NvimInvalidContainer xxx links to NvimInvalidParenthesis
"NvimInvalidCurly xxx links to NvimInvalidSubscript
"NvimInvalidDelimiter xxx links to NvimInvalid
"NvimInvalidDict xxx links to NvimInvalidContainer
"NvimInvalidDivision xxx links to NvimInvalidBinaryOperator
"NvimInvalidDoubleQuote xxx links to NvimInvalidStringQuote
"NvimInvalidDoubleQuotedBody xxx links to NvimInvalidStringBody
"NvimInvalidDoubleQuotedEscape xxx links to NvimInvalidStringSpecial
"NvimInvalidDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
"NvimInvalidEnvironmentName xxx links to NvimInvalidIdentifier
"NvimInvalidEnvironmentSigil xxx links to NvimInvalidOptionSigil
"NvimInvalidFigureBrace xxx links to NvimInvalidDelimiter
"NvimInvalidFloat xxx links to NvimInvalidNumber
"NvimInvalidIdentifier xxx links to NvimInvalidValue
"NvimInvalidIdentifierKey xxx links to NvimInvalidIdentifier
"NvimInvalidIdentifierName xxx links to NvimInvalidIdentifier
"NvimInvalidIdentifierScope xxx links to NvimInvalidIdentifier
"NvimInvalidIdentifierScopeDelimiter xxx links to NvimInvalidIdentifier
"NvimInvalidLambda xxx links to NvimInvalidParenthesis
"NvimInvalidList xxx links to NvimInvalidContainer
"NvimInvalidMod xxx links to NvimInvalidBinaryOperator
"NvimInvalidMultiplication xxx links to NvimInvalidBinaryOperator
"NvimInvalidNestingParenthesis xxx links to NvimInvalidParenthesis
"NvimInvalidNot xxx links to NvimInvalidUnaryOperator
"NvimInvalidNumber xxx links to NvimInvalidValue
"NvimInvalidNumberPrefix xxx links to NvimInvalidNumber
"NvimInvalidOperator xxx links to NvimInvalid
"NvimInvalidOptionName xxx links to NvimInvalidIdentifier
"NvimInvalidOptionScope xxx links to NvimInvalidIdentifierScope
"NvimInvalidOptionScopeDelimiter xxx links to NvimInvalidIdentifierScopeDelimiter
"NvimInvalidOptionSigil xxx links to NvimInvalidIdentifier
"NvimInvalidOr  xxx links to NvimInvalidBinaryOperator
"NvimInvalidParenthesis xxx links to NvimInvalidDelimiter
"NvimInvalidPlainAssignment xxx links to NvimInvalidAssignment
"NvimInvalidRegister xxx links to NvimInvalidValue
"NvimInvalidSingleQuote xxx links to NvimInvalidStringQuote
"NvimInvalidSingleQuotedBody xxx links to NvimInvalidStringBody
"NvimInvalidSingleQuotedQuote xxx links to NvimInvalidStringSpecial
"NvimInvalidSingleQuotedUnknownEscape xxx links to NvimInternalError
"NvimInvalidSpacing xxx links to ErrorMsg
"NvimInvalidString xxx links to NvimInvalidValue
"NvimInvalidStringBody xxx links to NvimStringBody
"NvimInvalidStringQuote xxx links to NvimInvalidString
"NvimInvalidStringSpecial xxx links to NvimStringSpecial
"NvimInvalidSubscript xxx links to NvimInvalidParenthesis
"NvimInvalidSubscriptBracket xxx links to NvimInvalidSubscript
"NvimInvalidSubscriptColon xxx links to NvimInvalidSubscript
"NvimInvalidTernary xxx links to NvimInvalidOperator
"NvimInvalidTernaryColon xxx links to NvimInvalidTernary
"NvimInvalidUnaryMinus xxx links to NvimInvalidUnaryOperator
"NvimInvalidUnaryOperator xxx links to NvimInvalidOperator
"NvimInvalidUnaryPlus xxx links to NvimInvalidUnaryOperator
"NvimInvalidValue xxx links to NvimInvalid
"NvimLambda     xxx links to NvimParenthesis
"NvimList       xxx links to NvimContainer
"NvimMod        xxx links to NvimBinaryOperator
"NvimMultiplication xxx links to NvimBinaryOperator
"NvimNestingParenthesis xxx links to NvimParenthesis
"NvimNot        xxx links to NvimUnaryOperator
"NvimNumber     xxx links to Number
"NvimNumberPrefix xxx links to Type
"NvimOperator   xxx links to Operator
"NvimOptionName xxx links to NvimIdentifier
"NvimOptionScope xxx links to NvimIdentifierScope
"NvimOptionScopeDelimiter xxx links to NvimIdentifierScopeDelimiter
"NvimOptionSigil xxx links to Type
"NvimOr         xxx links to NvimBinaryOperator
"NvimParenthesis xxx links to Delimiter
"NvimPlainAssignment xxx links to NvimAssignment
"NvimRegister   xxx links to SpecialChar
"NvimSingleQuote xxx links to NvimStringQuote
"NvimSingleQuotedBody xxx links to NvimStringBody
"NvimSingleQuotedQuote xxx links to NvimStringSpecial
"NvimSingleQuotedUnknownEscape xxx links to NvimInternalError
"NvimSpacing    xxx links to Normal
"NvimString     xxx links to String
"NvimStringBody xxx links to NvimString
"NvimStringQuote xxx links to NvimString
"NvimStringSpecial xxx links to SpecialChar
"NvimSubscript  xxx links to NvimParenthesis
"NvimSubscriptBracket xxx links to NvimSubscript
"NvimSubscriptColon xxx links to NvimSubscript
"NvimTernary    xxx links to NvimOperator
"NvimTernaryColon xxx links to NvimTernary
"NvimUnaryMinus xxx links to NvimUnaryOperator
"NvimUnaryOperator xxx links to NvimOperator
"NvimUnaryPlus  xxx links to NvimUnaryOperator

"Operator       xxx ctermfg=9 guifg=Red
"PreCondit      xxx links to PreProc
"PreProc        xxx ctermfg=81 guifg=#ff80ff
"Question       xxx cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00
"QuickFixLine   xxx links to Search
"Repeat         xxx ctermfg=15 guifg=white
"Search         xxx cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050
"SignColumn     xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
"Special        xxx ctermfg=5 guifg=Red
"SpecialChar    xxx links to Special
"SpecialComment xxx links to Special
"SpecialKey     xxx ctermfg=125 ctermbg=236 guifg=#af005f guibg=#303030
"SpellBad       xxx ctermbg=9 gui=undercurl guisp=Red
"SpellCap       xxx ctermbg=12 gui=undercurl guisp=Blue
"SpellLocal     xxx ctermbg=14 gui=undercurl guisp=Cyan
"SpellRare      xxx ctermbg=13 gui=undercurl guisp=Magenta
"Statement      xxx ctermfg=11 guifg=#aa4444
"StatusLine     xxx cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
"StatusLineNC   xxx ctermfg=249 ctermbg=237 guifg=#b2b2b2 guibg=#3a3a3a
"StorageClass   xxx links to Type
"String         xxx links to Constant
"Structure      xxx links to Type
"Substitute     xxx links to Search

"SyntasticError xxx links to SpellBad
"SyntasticErrorLine xxx cleared
"SyntasticErrorSign xxx links to Error
"SyntasticStyleError xxx links to SyntasticError
"SyntasticStyleErrorLine xxx links to SyntasticErrorLine
"SyntasticStyleErrorSign xxx links to SyntasticErrorSign
"SyntasticStyleWarning xxx links to SyntasticWarning
"SyntasticStyleWarningLine xxx links to SyntasticWarningLine
"SyntasticStyleWarningSign xxx links to SyntasticWarningSign
"SyntasticWarning xxx links to SpellCap
"SyntasticWarningLine xxx cleared
"SyntasticWarningSign xxx links to Todo

"TabLine        xxx ctermfg=255 ctermbg=19 guifg=#eeeeee guibg=#0000af
"TabLineFill    xxx ctermfg=255 ctermbg=19 guifg=#eeeeee guibg=#0000af
"TabLineSel     xxx cterm=bold ctermfg=220 ctermbg=22 gui=bold guifg=#ffd700 guibg=#005f00
"Tag            xxx links to Special
"TermCursor     xxx cterm=reverse gui=reverse
"TermCursorNC   xxx cleared
"Title          xxx ctermfg=225 gui=bold guifg=Magenta
"Todo           xxx cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
"Type           xxx ctermfg=121 guifg=#60ff60
"Typedef        xxx links to Type
"Underlined     xxx cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
"VertSplit      xxx cterm=bold ctermfg=21 ctermbg=0 gui=bold guifg=#0000ff guibg=#000000
"Visual         xxx cterm=bold ctermbg=54 gui=bold guibg=#5f0087
"VisualNC       xxx cleared
"WarningMsg     xxx cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00
"Whitespace     xxx links to NonText
"WildfireMark   xxx links to WarningMsg
"WildfirePrompt xxx links to String
"WildfireShade  xxx links to Comment

"cssStyle       xxx cleared

"diffAdded      xxx links to DiffAdd
"diffChanged    xxx links to DiffChange
"diffComment    xxx links to Comment
"diffCommon     xxx links to Normal
"diffFile       xxx cterm=bold ctermfg=15 ctermbg=0 gui=bold guifg=#ffffff guibg=#000000
"diffIdentical  xxx links to Normal
"diffNewFile    xxx cterm=bold ctermfg=10 ctermbg=0 gui=bold guifg=#00ff00 guibg=#000000
"diffOldFile    xxx cterm=bold ctermfg=9 ctermbg=0 gui=bold guifg=#ff0000 guibg=#000000
"diffRemoved    xxx links to DiffDelete
"
"htmlArg        xxx links to Type
"htmlBold       xxx cterm=bold gui=bold
"htmlBoldItalic xxx cterm=bold,italic gui=bold,italic
"htmlBoldItalicUnderline xxx links to htmlBoldUnderlineItalic
"htmlBoldUnderline xxx cterm=bold,underline gui=bold,underline
"htmlBoldUnderlineItalic xxx cterm=bold,underline,italic gui=bold,underline,italic
"htmlComment    xxx links to Comment
"htmlCommentError xxx links to htmlError
"htmlCommentPart xxx links to Comment
"htmlCssDefinition xxx links to Special
"htmlCssStyleComment xxx links to Comment
"htmlEndTag     xxx links to Identifier
"htmlError      xxx links to Error
"htmlEvent      xxx links to javaScript
"htmlEventDQ    xxx cleared
"htmlEventSQ    xxx cleared
"htmlH1         xxx links to Title
"htmlH2         xxx links to htmlH1
"htmlH3         xxx links to htmlH2
"htmlH4         xxx links to htmlH3
"htmlH5         xxx links to htmlH4
"htmlH6         xxx links to htmlH5
"htmlHead       xxx links to PreProc
"htmlItalic     xxx cterm=italic gui=italic
"htmlItalicBold xxx links to htmlBoldItalic
"htmlItalicBoldUnderline xxx links to htmlBoldUnderlineItalic
"htmlItalicUnderline xxx links to htmlUnderlineItalic
"htmlItalicUnderlineBold xxx links to htmlBoldUnderlineItalic
"htmlLeadingSpace xxx links to None
"htmlLink       xxx links to Underlined
"htmlPreAttr    xxx links to String
"htmlPreError   xxx links to Error
"htmlPreProc    xxx links to PreProc
"htmlPreProcAttrError xxx links to Error
"htmlPreProcAttrName xxx links to PreProc
"htmlPreStmt    xxx links to PreProc
"htmlScriptTag  xxx cleared
"htmlSpecial    xxx links to Special
"htmlSpecialChar xxx links to Special
"htmlSpecialTagName xxx links to Exception
"htmlStatement  xxx links to Statement
"htmlStrike     xxx cterm=underline gui=underline
"htmlString     xxx links to String
"htmlTag        xxx links to Function
"htmlTagError   xxx links to htmlError
"htmlTagN       xxx cleared
"htmlTagName    xxx links to htmlStatement
"htmlTitle      xxx links to Title
"htmlUnderline  xxx cterm=underline gui=underline
"htmlUnderlineBold xxx links to htmlBoldUnderline
"htmlUnderlineBoldItalic xxx links to htmlBoldUnderlineItalic
"htmlUnderlineItalic xxx cterm=underline,italic gui=underline,italic
"htmlUnderlineItalicBold xxx links to htmlBoldUnderlineItalic
"htmlValue      xxx links to String

hi link javaAnnotation PreProc
hi link javaAnnotation PreProc
hi link javaAssert Statement
hi link javaBoolean Boolean
hi link javaBraces Function
hi link javaBranch Conditional
" hi link javaC_JavaLang xxx cleared
hi link javaCharacter Character
hi link javaClassDecl javaScopeDecl

hi link javaComment Comment
hi link javaComment2String javaString
hi link javaCommentCharacter javaCharacter
hi link javaCommentStar javaComment
hi link javaCommentString javaString
hi link javaCommentTitle SpecialComment

hi link javaConditional Conditional
hi link javaConstant Constant
" hi link javaDebugBoolean xxx cleared
" hi link javaDebugParen xxx cleared
" hi link javaDebugSpecial xxx cleared
" hi link javaDebugType xxx cleared
hi link javaDocComment Comment
hi link javaDocParam Constant
hi link javaDocSeeTag PreProc
hi link javaDocSeeTagParam Constant
hi link javaDocTags PreProc
" hi link javaE_JavaLang xxx cleared
hi link javaError Error
hi link javaError2 javaError
hi link javaExceptions Exception
hi link javaExternal Include
" hi link javaFold xxx cleared
hi link javaFuncDef Function
hi link javaLabel Label
" hi link javaLabelRegion xxx cleared
hi link javaLambdaDef Function
" hi link javaLangObject xxx cleared
hi link javaLineComment Comment
hi link javaMethodDecl Function
hi link javaNumber Number
" hi link javaOK xxx cleared
hi link javaOperator Operator
" hi link javaParen xxx cleared
" hi link javaParen1 xxx cleared
" hi link javaParen2 xxx cleared
hi link javaParenError javaError
" hi link javaParenT xxx cleared
" hi link javaParenT1 xxx cleared
" hi link javaParenT2 xxx cleared
" hi link javaR_JavaLang xxx cleared
hi link javaRepeat Repeat
hi link javaScopeDecl Scope

hi link javaScript Special
hi link javaScriptExpression javaScript

hi link javaSpaceError Error
hi link javaSpecial Special
hi link javaSpecialChar SpecialChar
hi link javaSpecialCharError Error
hi link javaSpecialError Error
hi link javaStatement Statement
hi link javaStorageClass StorageClass
hi link javaString String
hi link javaStringError Error
hi link javaTodo Todo
hi link javaType Type
hi link javaTypedef Typedef
hi link javaUserLabel Label
" hi link javaUserLabelRef javaUserLabel
hi link javaVarArg Function
" hi link javaX_JavaLang xxx cleared

"lCursor        xxx guifg=bg guibg=fg
"level1         xxx cleared
"level10        xxx cleared
"level10c       xxx ctermfg=12 guifg=blue
"level11        xxx cleared
"level11c       xxx ctermfg=10 guifg=green
"level12        xxx cleared
"level12c       xxx ctermfg=9 guifg=red
"level13        xxx cleared
"level13c       xxx ctermfg=14 guifg=cyan
"level14        xxx cleared
"level14c       xxx ctermfg=11 guifg=yellow
"level15        xxx cleared
"level15c       xxx ctermfg=12 guifg=blue
"level16        xxx cleared
"level16c       xxx ctermfg=10 guifg=green
"level1c        xxx ctermfg=10 guifg=green
"level2         xxx cleared
"level2c        xxx ctermfg=9 guifg=red
"level3         xxx cleared
"level3c        xxx ctermfg=14 guifg=cyan
"level4         xxx cleared
"level4c        xxx ctermfg=11 guifg=yellow
"level5         xxx cleared
"level5c        xxx ctermfg=12 guifg=blue
"level6         xxx cleared
"level6c        xxx ctermfg=10 guifg=green
"level7         xxx cleared
"level7c        xxx ctermfg=9 guifg=red
"level8         xxx cleared
"level8c        xxx ctermfg=14 guifg=cyan
"level9         xxx cleared
"level9c        xxx ctermfg=11 guifg=yellow
"nvimAutoEvent  xxx links to vimAutoEvent
"nvimHLGroup    xxx links to vimHLGroup
"nvimMap        xxx links to vimMap
"nvimUnmap      xxx links to vimUnmap
"vimAbb         xxx links to vimCommand
"vimAddress     xxx links to vimMark
"vimAuHighlight xxx links to vimHighlight
"vimAuSyntax    xxx cleared
"vimAugroup     xxx cleared
"vimAugroupError xxx links to vimError
"vimAugroupKey  xxx links to vimCommand
"vimAugroupSyncA xxx cleared
"vimAutoCmd     xxx links to vimCommand
"vimAutoCmdOpt  xxx links to vimOption
"vimAutoCmdSfxList xxx cleared
"vimAutoCmdSpace xxx cleared
"vimAutoEvent   xxx links to Type
"vimAutoEventList xxx cleared
"vimAutoSet     xxx links to vimCommand
"vimBehave      xxx links to vimCommand
"vimBehaveError xxx links to vimError
"vimBehaveModel xxx links to vimBehave
"vimBracket     xxx links to Delimiter
"vimBufnrWarn   xxx links to vimWarn
"vimClusterName xxx cleared
"vimCmdSep      xxx cleared
"vimCmplxRepeat xxx links to SpecialChar
"vimCollClass   xxx cleared
"vimCollClassErr xxx links to vimError
"vimCollection  xxx cleared
"vimCommand     xxx links to Statement
"vimComment     xxx links to Comment
"vimCommentString xxx links to vimString
"vimCommentTitle xxx links to PreProc
"vimCommentTitleLeader xxx cleared
"vimCondHL      xxx links to vimCommand
"vimContinue    xxx links to Special
"vimCtrlChar    xxx links to SpecialChar
"vimEcho        xxx cleared
"vimEchoHL      xxx links to vimCommand
"vimEchoHLNone  xxx links to vimGroup
"vimElseIfErr   xxx links to Error
"vimElseif      xxx links to vimCondHL
"vimEmbedError  xxx links to Normal
"vimEnvvar      xxx links to PreProc
"vimErrSetting  xxx links to vimError
"vimError       xxx links to Error
"vimEscapeBrace xxx cleared
"vimExecute     xxx cleared
"vimExtCmd      xxx cleared
"vimFBVar       xxx links to vimVar
"vimFTCmd       xxx links to vimCommand
"vimFTError     xxx links to vimError
"vimFTOption    xxx links to vimSynType
"vimFgBgAttrib  xxx links to vimHiAttrib
"vimFiletype    xxx cleared
"vimFilter      xxx cleared
"vimFold        xxx links to Folded
"vimFunc        xxx links to vimError
"vimFuncBlank   xxx cleared
"vimFuncBody    xxx cleared
"vimFuncKey     xxx links to vimCommand
"vimFuncName    xxx links to Function
"vimFuncSID     xxx links to Special
"vimFuncVar     xxx links to Identifier
"vimFunction    xxx cleared
"vimFunctionError xxx links to vimError
"vimGlobal      xxx cleared
"vimGroup       xxx links to Type
"vimGroupAdd    xxx links to vimSynOption
"vimGroupList   xxx cleared
"vimGroupName   xxx links to vimGroup
"vimGroupRem    xxx links to vimSynOption
"vimGroupSpecial xxx links to Special
"vimHLGroup     xxx links to vimGroup
"vimHLMod       xxx links to PreProc
"vimHiAttrib    xxx links to PreProc
"vimHiAttribList xxx links to vimError
"vimHiBang      xxx cleared
"vimHiCTerm     xxx links to vimHiTerm
"vimHiClear     xxx links to vimHighlight
"vimHiCtermColor xxx cleared
"vimHiCtermError xxx links to vimError
"vimHiCtermFgBg xxx links to vimHiTerm
"vimHiFontname  xxx cleared
"vimHiGroup     xxx links to vimGroupName
"vimHiGui       xxx links to vimHiTerm
"vimHiGuiFgBg   xxx links to vimHiTerm
"vimHiGuiFont   xxx links to vimHiTerm
"vimHiGuiFontname xxx cleared
"vimHiGuiRgb    xxx links to vimNumber
"vimHiKeyError  xxx links to vimError
"vimHiKeyList   xxx cleared
"vimHiLink      xxx cleared
"vimHiNmbr      xxx links to Number
"vimHiStartStop xxx links to vimHiTerm
"vimHiTerm      xxx links to Type
"vimHiTermcap   xxx cleared
"vimHighlight   xxx links to vimCommand
"vimIf          xxx cleared
"vimInsert      xxx links to vimString
"vimIsCommand   xxx cleared
"vimIskList     xxx cleared
"vimIskSep      xxx links to Delimiter
"vimKeyCode     xxx links to vimSpecFile
"vimKeyCodeError xxx links to vimError
"vimKeyword     xxx links to Statement
"vimLet         xxx links to vimCommand
"vimLineComment xxx links to vimComment
"vimMap         xxx links to vimCommand
"vimMapBang     xxx links to vimCommand
"vimMapLhs      xxx cleared
"vimMapMod      xxx links to vimBracket
"vimMapModErr   xxx links to vimError
"vimMapModKey   xxx links to vimFuncSID
"vimMapRhs      xxx cleared
"vimMapRhsExtend xxx cleared
"vimMark        xxx links to Number
"vimMarkNumber  xxx links to vimNumber
"vimMenuBang    xxx cleared
"vimMenuMap     xxx cleared
"vimMenuMod     xxx links to vimMapMod
"vimMenuName    xxx links to PreProc
"vimMenuNameMore xxx links to vimMenuName
"vimMenuPriority xxx cleared
"vimMenuRhs     xxx cleared
"vimMtchComment xxx links to vimComment
"vimNorm        xxx links to vimCommand
"vimNormCmds    xxx cleared
"vimNotFunc     xxx links to vimCommand
"vimNotPatSep   xxx links to vimString
"vimNotation    xxx links to Special
"vimNumber      xxx links to Number
"vimOnlyCommand xxx cleared
"vimOnlyHLGroup xxx cleared
"vimOnlyOption  xxx cleared
"vimOper        xxx links to Operator
"vimOperError   xxx links to Error
"vimOperParen   xxx cleared
"vimOption      xxx links to PreProc
"vimParenSep    xxx links to Delimiter
"vimPatRegion   xxx cleared
"vimPatSep      xxx links to SpecialChar
"vimPatSepErr   xxx links to vimPatSep
"vimPatSepR     xxx links to vimPatSep
"vimPatSepZ     xxx links to vimPatSep
"vimPatSepZone  xxx links to vimString
"vimPattern     xxx links to Type
"vimPlainMark   xxx links to vimMark
"vimPlainRegister xxx links to vimRegister
"vimRegion      xxx cleared
"vimRegister    xxx links to SpecialChar
"vimScriptDelim xxx links to Comment
"vimSearch      xxx links to vimString
"vimSearchDelim xxx links to Statement
"vimSep         xxx links to Delimiter
"vimSet         xxx cleared
"vimSetEqual    xxx cleared
"vimSetMod      xxx links to vimOption
"vimSetSep      xxx links to Statement
"vimSetString   xxx links to vimString
"vimSpecFile    xxx links to Identifier
"vimSpecFileMod xxx links to vimSpecFile
"vimSpecial     xxx links to Type
"vimStatement   xxx links to Statement
"vimStdPlugin   xxx cleared
"vimString      xxx links to String
"vimStringCont  xxx links to vimString
"vimSubst       xxx links to vimCommand
"vimSubst1      xxx links to vimSubst
"vimSubstDelim  xxx links to Delimiter
"vimSubstFlagErr xxx links to vimError
"vimSubstFlags  xxx links to Special
"vimSubstPat    xxx cleared
"vimSubstRange  xxx cleared
"vimSubstRep    xxx cleared
"vimSubstRep4   xxx cleared
"vimSubstSubstr xxx links to SpecialChar
"vimSubstTwoBS  xxx links to vimString
"vimSynCase     xxx links to Type
"vimSynCaseError xxx links to vimError
"vimSynContains xxx links to vimSynOption
"vimSynError    xxx links to Error
"vimSynKeyContainedin xxx links to vimSynContains
"vimSynKeyOpt   xxx links to vimSynOption
"vimSynKeyRegion xxx cleared
"vimSynLine     xxx cleared
"vimSynMatchRegion xxx cleared
"vimSynMtchCchar xxx cleared
"vimSynMtchGroup xxx cleared
"vimSynMtchGrp  xxx links to vimSynOption
"vimSynMtchOpt  xxx links to vimSynOption
"vimSynNextgroup xxx links to vimSynOption
"vimSynNotPatRange xxx links to vimSynRegPat
"vimSynOption   xxx links to Special
"vimSynPatMod   xxx cleared
"vimSynPatRange xxx links to vimString
"vimSynReg      xxx links to Type
"vimSynRegOpt   xxx links to vimSynOption
"vimSynRegPat   xxx links to vimString
"vimSynRegion   xxx cleared
"vimSynType     xxx links to vimSpecial
"vimSyncC       xxx links to Type
"vimSyncError   xxx links to Error
"vimSyncGroup   xxx links to vimGroupName
"vimSyncGroupName xxx links to vimGroupName
"vimSyncKey     xxx links to Type
"vimSyncLinebreak xxx cleared
"vimSyncLinecont xxx cleared
"vimSyncLines   xxx cleared
"vimSyncMatch   xxx cleared
"vimSyncNone    xxx links to Type
"vimSyncRegion  xxx cleared
"vimSyntax      xxx links to vimCommand
"vimTermOption  xxx cleared
"vimTodo        xxx links to Todo
"vimUnmap       xxx links to vimMap
"vimUserAttrb   xxx links to vimSpecial
"vimUserAttrbCmplt xxx links to vimSpecial
"vimUserAttrbCmpltFunc xxx links to Special
"vimUserAttrbError xxx links to Error
"vimUserAttrbKey xxx links to vimOption
"vimUserCmd     xxx cleared
"vimUserCmdError xxx links to Error
"vimUserCommand xxx links to vimCommand
"vimUserFunc    xxx links to Normal
"vimVar         xxx links to Identifier
"vimWarn        xxx links to WarningMsg

" for highlighting of any selected words, defined at runtime (see mappings.vim)
hi SPCustomHighlight term=reverse cterm=reverse gui=reverse

" color settings for the rainbow parentheses plugin
let g:rbpt_colorpairs = [
    \ ['82', '#5fff00'],
    \ ['197', '#ff005f'],
    \ ['159', '#afffff'],
    \ ['226', '#ffff00'],
    \ ['45', '#00d7ff'],
    \ ]

