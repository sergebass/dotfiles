" legacy.vim - temporary configuration in VimScript

""" -------------------------------
""" MISCELLANEOUS STUFF AND PLUGINS
""" -------------------------------

" remember edit position and jump to it next time the same file is edited
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

if exists("syntax_on")
  syntax reset
endif

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif

" automatically pick correct templates based on the specified file name extension
augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/templates/vim-template.'.expand("<afile>:e")
augroup END

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

filetype plugin indent on
syntax on

" Disable syntax highlighting for large files (over 1 MB)
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

set redrawtime=5000  " time in milliseconds for syntax redraw

" this is useful for nested terminals, to make them use the existing nvim instance, if available
if executable("nvr")
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" -------------------
" GENERAL UI SETTINGS
" -------------------

set guifont=Inconsolata:h11

if $TERM == "linux"
\ || $TERM == "screen-256color"
\ || $TERM == "xterm-256color"
\ || $TERM == "rxvt-unicode-256color"
\ || $COLORTERM == "xfce4-terminal"
\ || $COLORTERM == "gnome-terminal"
\ || $COLORTERM == "Terminal"
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" if we're in non-tty tmux session running neovim,
" we may try using 24-bit GUI color scheme settings directly
if $TMUX != "" && $TERM != "linux"
    " nvim is compiled with this feature, vim is most likely not
    " this setting may seem to conflict with the above
    " but since 24-bit colors are automatically mapped to their closest
    " 256-color counterparts, we may get away with this,
    " and this will work best in terminals with true 24-bit color support
    set termguicolors
endif

" make sure tmux correctly passes DECSCUSR cursor shape change sequences
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" FIXME Uncomment when it's clear how to make this work with urxvt...
" if &term =~ '^xterm\\|rxvt'
"   " use an orange cursor in insert mode
"   let &t_SI = "\<Esc>]12;orange\x7"
"   " use a red cursor otherwise
"   let &t_EI = "\<Esc>]12;red\x7"
"   silent !echo -ne "\033]12;red\007"
"   " reset cursor when vim exits
"   autocmd VimLeave * silent !echo -ne "\033]112\007"
"   " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
"
"   " solid underscore
"   let &t_SI .= "\<Esc>[4 q"
"   " solid block
"   let &t_EI .= "\<Esc>[2 q"
"   " 1 or 0 -> blinking block
"   " 3 -> blinking underscore
"   " Recent versions of xterm (282 or above) also support
"   " 5 -> blinking vertical bar
"   " 6 -> solid vertical bar
" endif

" use a dark theme by default (there's a shortcut to quickly switch it, if needed)
" (one other option may be to have the "if &termguicolors" check for auto detection)
colorscheme sergebass-dark

" try to use transparent background, if supported (see background erasure (BCE) mode in terminals)
if !(exists("g:GuiLoaded") || has("gui_running")) " GUI vim/neovim versions don't support transparent backgrounds
    hi Normal ctermbg=NONE guibg=NONE
endif

" FIXME replace rainbow parenthese plugin with the one from
" https://github.com/luochen1990/rainbow (hopefully this works properly)
"
" chevron matching mode conflicts with XHTML highlighting so disable it for now
"au Syntax * RainbowParenthesesLoadChevrons
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

au VimEnter * RainbowParenthesesToggle

" Force .h and .inl files to be treated as C++ headers
au BufReadPost *.h set filetype=cpp
au BufReadPost *.inl set filetype=cpp

au BufReadPost *.nasm set filetype=asm

au BufReadPost *.gdb set filetype=gdb

" Frege sources are very much Haskell-like
au BufReadPost *.fr set filetype=frege syntax=haskell

" Special configuration files
au BufReadPost */.xmobarrc set filetype=haskell
au BufReadPost */gitconfig set filetype=gitconfig
au BufReadPost */_gitconfig set filetype=gitconfig
au BufReadPost */.vrapperrc set filetype=vim

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl

autocmd FileType json syntax match Comment +\/\/.\+$+
