""" --------------
""" THEME SETTINGS
""" --------------

" let g:colors_name = "sergebass"

" FIXME temporary highlighting placeholders, taken from vim documentation;
" uncomment and fix.
"
" Conceal     placeholder characters substituted for concealed text (see 'conceallevel')
"
" Directory   directory names (and other special names in listings)
" FoldColumn  'foldcolumn'
" SignColumn  column where |signs| are displayed
" Pmenu       Popup menu: normal item.
" PmenuSel    Popup menu: selected item.
" PmenuSbar   Popup menu: scrollbar.
" PmenuThumb  Popup menu: Thumb of the scrollbar.
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
" WildMenu    current match in 'wildmenu' completion

hi Normal term=none cterm=none ctermfg=250 ctermbg=0 gui=none guifg=#c0c0c0 guibg=#000000

hi Cursor term=reverse cterm=bold ctermfg=0 ctermbg=214 gui=bold guifg=black guibg=#ffaf00
hi CursorIM term=reverse cterm=bold ctermfg=0 ctermbg=201 gui=bold guifg=black guibg=#ff00ff
hi NonText term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi EndOfBuffer term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi Ignore ctermfg=black guifg=bg
hi VertSplit term=reverse cterm=bold ctermfg=21 ctermbg=0 gui=bold guifg=#0000ff guibg=#000000
hi Folded term=reverse ctermfg=yellow ctermbg=238 guifg=Yellow guibg=#303030
hi MatchParen term=reverse cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050

hi MoreMsg cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
hi ModeMsg term=reverse cterm=bold ctermfg=226 ctermbg=22 gui=bold guifg=#ffff00 guibg=#005f00
hi ErrorMsg term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi WarningMsg term=reverse cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00
hi Question term=reverse cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00

hi Search term=reverse cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050
hi IncSearch term=reverse cterm=bold ctermfg=226 ctermbg=24 gui=bold guifg=#ffff00 guibg=#005050

highlight Visual term=reverse cterm=bold ctermbg=54 gui=bold guibg=#5f0087

hi Special term=bold ctermfg=DarkMagenta guifg=Red
hi Comment term=bold ctermfg=DarkCyan guifg=#80a0ff
hi Constant term=underline ctermfg=Magenta guifg=Magenta
hi Identifier term=underline cterm=none ctermfg=Cyan guifg=#40ffff
hi Statement term=none ctermfg=Yellow gui=none guifg=#aa4444
hi PreProc term=underline ctermfg=LightBlue guifg=#ff80ff
hi Type term=underline ctermfg=LightGreen guifg=#60ff60 gui=none
hi Function term=bold ctermfg=White guifg=White
hi Repeat term=underline ctermfg=White guifg=white
hi Operator ctermfg=Red guifg=Red
hi Error term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi Todo term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000

hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Conditional Repeat
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

highlight DiffAdd cterm=bold ctermfg=Yellow ctermbg=22 gui=bold guifg=Yellow guibg=#004000
highlight DiffDelete cterm=bold ctermfg=Yellow ctermbg=88 gui=bold guifg=Yellow guibg=#400000
highlight DiffChange cterm=bold ctermfg=Yellow ctermbg=18 gui=bold guifg=Yellow guibg=#000040
highlight DiffText cterm=inverse ctermfg=Yellow ctermbg=18 gui=inverse guifg=Yellow guibg=#000040

" this is needed to make git commit respect our existing diff highlighting
highlight link diffCommon Normal
highlight link diffIdentical Normal
highlight link diffAdded DiffAdd
highlight link diffChanged DiffChange
highlight link diffRemoved DiffDelete
highlight link diffComment Comment

highlight diffFile cterm=bold ctermfg=15 ctermbg=0 gui=bold guifg=#ffffff guibg=#000000
highlight diffOldFile cterm=bold ctermfg=9 ctermbg=0 gui=bold guifg=#ff0000 guibg=#000000
highlight diffNewFile cterm=bold ctermfg=10 ctermbg=0 gui=bold guifg=#00ff00 guibg=#000000

" FIXME check all these other highlight settings:
" diffOnly       xxx links to Constant
" diffDiffer     xxx links to Constant
" diffBDiffer    xxx links to Constant
" diffIsA        xxx links to Constant
" diffNoEOL      xxx links to Constant
" diffSubname    xxx links to PreProc
" diffLine       xxx links to Statement
" diffIndexLine  xxx links to PreProc

highlight link GitGutterAdd DiffAdd
highlight link GitGutterDelete DiffDelete
highlight link GitGutterChange DiffChange
highlight link GitGutterChangeDelete DiffChange

highlight StatusLine cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
highlight StatusLineNC cterm=none ctermfg=249 ctermbg=237 gui=none guifg=#b2b2b2 guibg=#3a3a3a

" change statusline colors depending on the current mode
if version >= 700
  au InsertEnter * highlight StatusLine cterm=bold ctermfg=15 ctermbg=22 gui=bold guifg=#ffffff guibg=#005f00
  au InsertLeave * highlight StatusLine cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
endif

highlight TabLine term=none cterm=none ctermfg=255 ctermbg=19 gui=none guifg=#eeeeee guibg=#0000af
highlight TabLineFill term=none cterm=none ctermfg=255 ctermbg=19 gui=none guifg=#eeeeee guibg=#0000af
highlight TabLineSel term=reverse cterm=bold ctermfg=220 ctermbg=22 gui=bold guifg=#ffd700 guibg=#005f00

highlight MyWordHighlight cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
match MyWordHighlight "\<\(TODO\|FIXME\|XXX\|BUG\|ASAP\)"

" show non-space whitespace using this coloring:
highlight SpecialKey cterm=none ctermfg=125 ctermbg=236 gui=none guifg=#af005f guibg=#303030

" line length limit highlighting
highlight ColorColumn ctermbg=234 guibg=#301010

" make current line and its number stand out from the rest
highlight CursorLine cterm=none ctermbg=236 gui=none guibg=#404030
highlight CursorColumn cterm=none ctermbg=236 gui=none guibg=#404030
highlight CursorLineNr cterm=bold ctermfg=245 ctermbg=0 gui=bold guifg=#808080 guibg=#000000
highlight LineNr cterm=none ctermfg=240 ctermbg=0 gui=none guifg=#606060 guibg=#000000

" color settings for the rainbow parentheses plugin
let g:rbpt_colorpairs = [
    \ ['green',  'green'],
    \ ['red',    'red'],
    \ ['cyan',   'cyan'],
    \ ['yellow', 'yellow'],
    \ ['blue',   'blue'],
    \ ]
