{
  description = "NixOS configuration for cm130";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    musnix.url = "github:musnix/musnix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.cm130 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        ./configuration.nix
      ];
      specialArgs = { inherit inputs system; };
    };
  };
}
