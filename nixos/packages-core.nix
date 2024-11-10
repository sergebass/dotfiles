# The list of core packages that I need on every NixOS system

pkgs: with pkgs; [
  bc  # GNU software calculator
  dig  # Domain name server utility
  fastfetch  # Like neofetch, but much faster because written in C
  file  # A program that shows the type of files
  findutils  # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
  fish  # Smart and user-friendly command line shell
  fzf  # Command-line fuzzy finder written in Go
  git  # Distributed version control system
  htop  # An interactive process viewer
  hwinfo  # Hardware detection tool from openSUSE
  kbd  # Linux keyboard tools and keyboard maps
  lm_sensors  # Onboard sensor measurement tools
  lshw  # Provide detailed information on the hardware configuration of the machine
  mc  # File Manager and User Shell for the GNU Project, known as Midnight Commander
  neovim  # Vim text editor fork focused on extensibility and agility
  parted  # Create, destroy, resize, check, and copy partitions
  ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
  rsync  # Fast incremental file transfer utility
  tig  # Text-mode interface for git
  tmux  # Terminal multiplexer
  tree  # Command to produce a depth indented directory listing
  unzip  # An extraction utility for archives compressed in .zip format
  usbutils  # Tools for working with USB devices, such as lsusb
  wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
  zip  # Compressor/archiver for creating and modifying zipfiles
]
