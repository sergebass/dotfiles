# NixOS configuration for Arduino development support.
{ config, lib, pkgs, ... } : {
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      arduino-cli  # Arduino from the command line
      arduino-ide  # Open-source electronics prototyping platform
      arduino-language-server  # Arduino Language Server based on Clangd to Arduino code autocompletion
    ];
  };
}
