{
  description = "NixOS configuration for t14s";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.t14s = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        ./configuration.nix
      ];
      specialArgs = { inherit inputs system; };
    };
  };
}
