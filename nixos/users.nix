# Nix module for user registration and user-specific configuration
{ config, lib, pkgs, ... }:
let
  userName = "sergii";
  userId = 1000;

in {
  imports = [
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = let
    normalUserGroups = [
      "audio"
      "dialout"  # to access /dev/ttyACM ports (e.g. Arduino)
      "lp"  # Printer access
      "networkmanager"
      "plugdev"  # For e.g. RTL-SDR
      "scanner"
      "video"
    ];
    powerUserGroups = normalUserGroups ++ [
      "adm"
      "lpadmin"  # Printer administration
      "wheel"  # Enable 'sudo' for the user.
    ];
  in {
    mutableUsers = true;

    defaultUserShell = pkgs.fish;

    users = {
      "${userName}" = {
        uid = userId;
        isNormalUser = true;
        extraGroups = powerUserGroups;
        initialPassword = "changeme";
      };

      # Add other managed user entries here
    };
  };

  # Copy the user icon avatar to /var/lib/AccountsService/icons/$user
  # (unfortunately, this is how display manager locate user icons)
  system.activationScripts.userIconInstallationScript = {
    text = ''
      # FIXME TODO do not fail if the icon is missing
      echo "Installing user avatar icons for discovery by display managers..."
      mkdir -p /var/lib/AccountsService/icons/
      install -v -m 644 ${config.users.users.${userName}.home}/.face.icon /var/lib/AccountsService/icons/${userName}
    '';
  };
}
