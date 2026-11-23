{
  description = "NixOS configuration for pi400";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.pi400 = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        ./configuration.nix
      ];
      specialArgs = { inherit inputs system; };
    };
  };
}
