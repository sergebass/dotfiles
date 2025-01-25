# Nix module to configure system-wide version control tools
{ config, lib, pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      lfs.enable = true;  # Large File Support

      config = [
        {
          user.name = "Sergii Perynskyi";
        }
        {
          init = {
            defaultBranch = "main";
          };
        }
        {
          aliases = {
          };
        }
      ];
    };
  };
}
