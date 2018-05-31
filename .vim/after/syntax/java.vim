" Java-specific syntax highlighting

" this does not seem to work very well... :(
" let java_highlight_functions = 1
"
" syn region javaFuncDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)\s\+\)*\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(<[^>]*>\)\=\(\[\]\)*\s\+\zs[a-z][A-Za-z0-9_$]*\|\zs[A-Z][A-Za-z0-9_$]*\)\s*\ze(+ end=+\ze(+ contains=javaScopeDecl,javaType,javaStorageClass,javaComment,javaLineComment,@javaClasses

syn keyword headsUp FIXME TODO BUG XXX ASAP
hi HeadsUp term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi def link HeadsUp headsUp

syn match SPUpperCaseJavaWord "\<[A-Z]\h*\>"
hi def link SPUpperCaseJavaWord javaType

syn keyword externalScope this super
hi ExternalScope term=bold cterm=none ctermfg=198 gui=none guifg=#ff0087
hi def link ExternalScope externalScope

syn keyword exitFunction return throw
hi ExitFunction term=underline cterm=none ctermfg=226 gui=none guifg=#ffff00
hi def link ExitFunction exitFunction

syn keyword javaScopePublic public
syn keyword javaScopePrivate private
syn keyword javaScopeProtected protected

hi JavaScopePublic term=none cterm=none ctermfg=118 gui=none guifg=#87ff00
hi JavaScopePrivate term=none cterm=none ctermfg=213 gui=none guifg=#ff87ff
hi JavaScopeProtected term=none cterm=none ctermfg=228 gui=none guifg=#ffff87

hi def link JavaScopePublic javaScopePublic
hi def link JavaScopePrivate javaScopePrivate
hi def link JavaScopeProtected javaScopeProtected

