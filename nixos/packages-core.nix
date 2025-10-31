# The list of core packages that I need on every NixOS system
# Note that several core programs are configured in other Nix modules
# (e.g. tmux, fish, fzf, git etc. - usually in `programs.abc` blocks)

pkgs: with pkgs; [
  bc  # GNU software calculator
  cmus  # Small, fast and powerful console music player for Linux and *BSD
  dig  # Domain name server utility
  file  # A program that shows the type of files
  findutils  # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
  fq  # jq for binary formats
  gh  # GitHub CLI tool
  htop  # An interactive process viewer
  jq  # Lightweight and flexible command-line JSON processor
  kbd  # Linux keyboard tools and keyboard maps
  mc  # File Manager and User Shell for the GNU Project, known as Midnight Commander
  moc  # Terminal audio player designed to be powerful and easy to use
  mpc  # Minimalist command line interface to MPD
  ncdu  # Disk usage analyzer with an ncurses interface
  ncmpcpp  # Featureful ncurses based MPD client inspired by ncmpc
  ncpamixer  # Terminal mixer for PulseAudio inspired by pavucontrol
  nushell  # Modern shell written in Rust
  openpomodoro-cli  # Command-line Pomodoro tracker which uses the Open Pomodoro Format
  pamixer  # CLI utilities to control PA & PW audio levels
  psmisc  # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
  python3Minimal  # High-level dynamically-typed programming language
  ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
  rlwrap  # Readline wrapper for console programs
  rsync  # Fast incremental file transfer utility
  rtorrent  # Ncurses client for libtorrent, ideal for use with screen, tmux, or dtach
  speedtest-rs  # Command line internet speedtest tool written in rust
  sqlite-interactive  # Self-contained, serverless, zero-configuration, transactional SQL database engine
  starship  # Command prompt generator (we have it in programs.starship but it's not on PATH for some reason)
  tig  # Text-mode interface for git
  tinyxxd  # Drop-in replacement and standalone version of the hex dump utility that comes with ViM
  tree  # Command to produce a depth indented directory listing
  universal-ctags  # A maintained ctags implementation
  unzip  # An extraction utility for archives compressed in .zip format
  vifm  # Vi-like File Manager
  wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
  xcd  # Colorized hexdump tool
  zip  # Compressor/archiver for creating and modifying zipfiles
]
