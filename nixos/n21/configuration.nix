# NixOS configuration for Lenovo N21 Chromebook

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  useDM = false;

in {
  imports = [
    ./hardware-configuration.nix  # Results of the hardware scan. To redo detection: nixos-generate-config
    ../common-configuration.nix  # Common configuration shared by all of our NixOS systems
  ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = lib.mkForce [ "verbose" "nosplash" ];

    blacklistedKernelModules = [
      "dvb_usb_rtl28xxu"  # for SDR dongle
    ];

    tmp.useTmpfs = true;  # Save SSD from some wear and tear
  };

  hardware = {
    # Scanner support
    sane = {
      enable = true;
      brscan4.enable = true;  # Brother DCP-7060D scanner
    };

    firmware = with pkgs; [
      libreelec-dvb-firmware  # DVB firmware from LibreELEC (for many TV tuner devices)
    ];
  };

  networking = {
    hostName = "n21";

    firewall = {
      enable = true;
    };
  };

  services = {
    udev = {
      enable = true;

      packages = with pkgs; [
        openhantek6022  # Make sure we can access our USB oscilloscope properly
        rtl-sdr  # For Nooelec Software Defined Radio dongle
      ];

      # A rule to allow ACPI backlight control by a non-root user from video group
      extraRules = with pkgs; ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
      '';
    };

    gvfs.enable = true;  # Mount, trash, and other functionalities

    xserver = {
      enable = true;

      displayManager = {
        startx.enable = ! useDM;

        lightdm = {
          enable = useDM;
          greeter.enable = true;
          background = /home/${userName}/.background-image;
        };
      };

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          mode = "max";
          combineScreens = false;
        };
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };

      xkb = {
        layout = "us,us(intl),ru,ua";
        options = "grp:shift_caps_toggle";
      };
    };

    libinput.enable = true;  # Enable touchpad support

    blueman.enable = true;

    system-config-printer.enable = true;

    printing = {
      enable = true;  # Enable CUPS
      cups-pdf.enable = true;
      browsing = true;  # Advertise shared printers on our LAN
      drivers = with pkgs; [
        brlaser  # For Brother DCP-7060D (and others)
      ];
    };

    # Music Player Daemon
    mpd = {
      enable = true;
      startWhenNeeded = true;  # systemd feature: only start MPD service upon connection to its socket

      user = userName;  # Do not run as root

      network = {
        listenAddress = "any";  # Allow non-localhost connections
        port = 6600;  # port 6600 is the default
      };

      musicDirectory = "/home/${userName}/music";
      playlistDirectory = "/home/${userName}/music/playlists";

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }

        audio_output {
          type "pulse"
          name "PulseAudio"
          # server "remote_server" # optional
          # sink "remote_server_sink" # optional
        }

        # Audio output for use on Linux
        audio_output {
          type "alsa"
          name "ALSA (default)"
          # device "hw:0,0" # optional
          # format "44100:16:2" # optional
          # mixer_type "hardware" # optional
          # mixer_device "default" # optional
          # mixer_control "PCM" # optional
          # mixer_index "0" # optional
        }
      '';
    };
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString userId}"; # MPD will look inside this directory for the PipeWire socket.
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      alacritty
      arduino-cli  # Arduino from the command line
      arduino-ide  # Open-source electronics prototyping platform
      arduino-language-server  # Arduino Language Server based on Clangd to Arduino code autocompletion
      chromium
      dmenu
      dunst
      feh
      firefox
      freetube
      gparted
      gqrx
      mpc_cli
      mpd
      mpv
      mupdf
      ncmpcpp
      openhantek6022  # Free software for Hantek and compatible (Voltcraft/Darkwire/Protek/Acetech) USB digital signal oscilloscopes
      pavucontrol
      qrencode
      rofi
      rofi-bluetooth
      rofi-calc
      rofi-file-browser
      rofi-mpd
      rofi-pulse-select
      rofi-systemd
      rofi-top
      simple-scan  # Simple paper scanning GUI app
      w_scan2  # A small channel scan tool which generates ATSC, DVB-C, DVB-S/S2 and DVB-T/T2 channels.conf files. Use: w_scan2 -fa -c CA > channels.conf
      xorg.xkill
      xorg.xrandr
      xorg.xsetroot
      ymuse  # GUI client for MPD
    ];
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
