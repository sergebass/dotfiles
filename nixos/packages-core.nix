# The list of core packages that I need on every NixOS system
# Note that several core programs are configured in other Nix modules
# (e.g. tmux, fish, fzf, git etc. - usually in `programs.abc` blocks)

pkgs: with pkgs; [
  alsa-utils  # ALSA, the Advanced Linux Sound Architecture utils
  bc  # GNU software calculator
  dig  # Domain name server utility
  exfatprogs  # exFAT filesystem userspace utilities
  fastfetch  # Like neofetch, but much faster because written in C
  file  # A program that shows the type of files
  findutils  # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
  hddtemp  # HDD temperature measurement tools
  htop  # An interactive process viewer
  hwinfo  # Hardware detection tool from openSUSE
  kbd  # Linux keyboard tools and keyboard maps
  lm_sensors  # Onboard sensor measurement tools
  lshw  # Provide detailed information on the hardware configuration of the machine
  mc  # File Manager and User Shell for the GNU Project, known as Midnight Commander
  pamixer  # CLI utilities to control PA & PW audio levels
  parted  # Create, destroy, resize, check, and copy partitions
  pciutils  # A collection of programs for inspecting and manipulating configuration of PCI devices
  ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
  rsync  # Fast incremental file transfer utility
  speedtest-rs  # Command line internet speedtest tool written in rust
  starship  # Command prompt generator (we have it in programs.starship but it's not on PATH for some reason)
  tig  # Text-mode interface for git
  tree  # Command to produce a depth indented directory listing
  universal-ctags  # A maintained ctags implementation
  unzip  # An extraction utility for archives compressed in .zip format
  usbutils  # Tools for working with USB devices, such as lsusb
  vifm  # Vi-like File Manager
  wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
  zip  # Compressor/archiver for creating and modifying zipfiles
]
