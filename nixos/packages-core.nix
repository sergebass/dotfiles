# The list of core packages that I need on every NixOS system
# Note that several core programs are configured in other Nix modules
# (e.g. tmux, fish, fzf, git etc. - usually in `programs.abc` blocks)

pkgs: with pkgs; [
  alsa-utils  # ALSA, the Advanced Linux Sound Architecture utils
  bc  # GNU software calculator
  btrfs-heatmap  # Visualize the layout of a mounted btrfs
  btrfs-progs  # Utilities for the btrfs filesystem
  btrfs-snap  # Create and maintain the history of snapshots of btrfs filesystems
  compsize  # Compression ratio calculator for btrfs
  dig  # Domain name server utility
  exfatprogs  # exFAT filesystem userspace utilities
  fastfetch  # Like neofetch, but much faster because written in C
  file  # A program that shows the type of files
  findutils  # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
  gh  # GitHub CLI tool
  hddtemp  # HDD temperature measurement tools
  htop  # An interactive process viewer
  hwinfo  # Hardware detection tool from openSUSE
  kbd  # Linux keyboard tools and keyboard maps
  lm_sensors  # Onboard sensor measurement tools
  lshw  # Provide detailed information on the hardware configuration of the machine
  mc  # File Manager and User Shell for the GNU Project, known as Midnight Commander
  mpc  # Minimalist command line interface to MPD
  ncmpcpp  # Featureful ncurses based MPD client inspired by ncmpc
  ncpamixer  # Terminal mixer for PulseAudio inspired by pavucontrol
  openpomodoro-cli  # Command-line Pomodoro tracker which uses the Open Pomodoro Format
  pamixer  # CLI utilities to control PA & PW audio levels
  parted  # Create, destroy, resize, check, and copy partitions
  pciutils  # A collection of programs for inspecting and manipulating configuration of PCI devices
  psmisc  # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
  python3Minimal  # High-level dynamically-typed programming language
  ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
  rlwrap  # Readline wrapper for console programs
  rsync  # Fast incremental file transfer utility
  rtorrent  # Ncurses client for libtorrent, ideal for use with screen, tmux, or dtach
  simple-mtpfs  # Simple MTP fuse filesystem driver (for Android phones, Garmin watches etc.)
  speedtest-rs  # Command line internet speedtest tool written in rust
  starship  # Command prompt generator (we have it in programs.starship but it's not on PATH for some reason)
  tig  # Text-mode interface for git
  tinyxxd  # Drop-in replacement and standalone version of the hex dump utility that comes with ViM
  tree  # Command to produce a depth indented directory listing
  universal-ctags  # A maintained ctags implementation
  unzip  # An extraction utility for archives compressed in .zip format
  usbutils  # Tools for working with USB devices, such as lsusb
  vifm  # Vi-like File Manager
  wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
  zfs  # ZFS Filesystem Linux Userspace Tools
  zip  # Compressor/archiver for creating and modifying zipfiles
]
