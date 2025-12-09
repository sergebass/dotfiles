-------------------------------------
-- Rust-specific neovim configuration
-------------------------------------

vim.cmd([[
  runtime sergebass/gdb.vim

  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  nnoremap <buffer> <F1> :!sp-open "https://doc.rust-lang.org/reference"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://docs.rs"<CR>

  " Search the word under cursor in docs.rs (using browser)
  nnoremap <buffer> \\? :!sp-open "https://docs.rs/releases/search?query=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://docs.rs/releases/search?query=<C-r>*"<Left>

  " -----------------------
  " Spacemacs-style keymaps
  " -----------------------

  " SPC m = =     reformat the buffer
  nmap <buffer> <Space>m== :RustFmt<CR>

  " SPC m b R     reload Rust-Analyzer workspace
  " SPC m c .     rerun the default binary with the same arguments
  " SPC m c =     format all project files with rustfmt
  " SPC m c a     add a new dependency with cargo-edit
  " SPC m c c     compile project
  " SPC m c C     remove build artifacts
  " SPC m c d     generate documentation and open it in default browser
  " SPC m c s     search the documentation
  " SPC m c e     run benchmarks
  " SPC m c i     initialise a new project with Cargo (init)
  " SPC m c l     run linter (cargo-clippy)
  " SPC m c f     run linter automatic fixes (cargo-clippy)
  " SPC m c n     create a new project with Cargo (new)
  " SPC m c o     display outdated dependencies (cargo-outdated)
  " SPC m c r     remove a dependency with cargo-edit
  " SPC m c u     update dependencies with Cargo
  " SPC m c U     upgrade dependencies to LATEST version with cargo-edit
  " SPC m c v     check (verify) a project with Cargo
  " SPC m c x     execute the default binary
  " SPC m g g     jump to definition
  " SPC m h h     describe symbol at point
  " SPC m s s     switch to other LSP server backend
  " SPC m t a     test current project
  " SPC m t t     run the current test

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Rust settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-rust.vim"))
      source ~/.workspace-rust.vim
  endif
]])
