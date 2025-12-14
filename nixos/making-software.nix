# NixOS configuration for making software (programming and related stuff)

{ config, lib, pkgs, ... }:

let systemPythonPackages = packageRoot: with packageRoot; [
  mido  # MIDI Objects for Python
  packaging  # Core utilities for Python packages
  python-rtmidi  # Python wrapper for RtMidi
];

in {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
    ./development/android.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      (python3.withPackages systemPythonPackages)
      bash-language-server  # A language server for Bash
      cargo  # Downloads your Rust project's dependencies and builds your project
      ccache  # C++ compiler cache
      ccls  # C/C++ language server powered by clang
      clang  # C language family frontend for LLVM (wrapper script)
      clang-tools  # Standalone command line tools for C++ development (clangd, clang-format etc.)
      cmake-language-server  # CMake LSP Implementation
      cmakeCurses  # Cross-platform, open-source build system generator
      gcc  # GNU Compiler Collection
      gdb  # GNU debugger
      gnumake  # Tool to control the generation of non-source files from sources
      haskell-language-server  # LSP server for GHC
      jdk  # The open-source Java Development Kit
      jqp  # TUI playground to experiment with jq
      kotlin-language-server  # Kotlin language server
      lldb  # LLVM debugger
      llvmPackages.clangUseLLVM  # C language family frontend for LLVM (wrapper script)
      lua-language-server  # Language server that offers Lua language support
      meld  # Visual diff and merge tool
      nixd  # Feature-rich Nix language server interoperating with C++ nix
      nodePackages.purescript-language-server  # Language Server Protocol server for PureScript wrapping purs ide server functionality
      nodejs_24  # Event-driven I/O framework for the V8 JavaScript engine (Node.JS and NPM)
      pkg-config  # A tool that allows packages to find out information about other packages (wrapper script)
      postgres-language-server  # Tools and language server for Postgres
      python3Packages.debugpy  # Implementation of the Debug Adapter Protocol for Python
      python3Packages.python-lsp-server  # Python implementation of the Language Server Protocol (pylsp)
      rust-analyzer  # Language server for the Rust language
      rust-bindgen  # Automatically generates Rust FFI bindings to C (and some C++) libraries
      rustc  # Rust compiler
      rustfmt  # Tool for formatting Rust code according to style guidelines
      sqlitebrowser  # DB Browser for SQLite
      systemd-language-server  # Language Server for Systemd unit files
      typescript  # Superset of JavaScript that compiles to clean JavaScript output
      typescript-language-server  # Language Server Protocol implementation for TypeScript using tsserver (https://github.com/typescript-language-server/typescript-language-server)
      vim-language-server  # VImScript language server, LSP for vim script
      vscode-extensions.ms-vscode.cpptools  # C/C++ extension adds language support for C/C++ to Visual Studio Code, including features such as IntelliSense and debugging
      vscode-with-extensions  # Code editor developed by Microsoft
      vscodium-fhs  # Wrapped variant of vscodium which launches in a FHS compatible environment, should allow for easy usage of extensions without nix-specific modifications
      yaml-language-server  # Language Server for YAML Files
      zuban  # Mypy-compatible Python Language Server built in Rust
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];

    variables = {
    };
  };
}
