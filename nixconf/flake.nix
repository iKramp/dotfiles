{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs_24_05.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, nixpkgs_old, nixpkgs_24_05 }@inputs: 
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      pkgs_old = import nixpkgs_old {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      pkgs_24_05 = import nixpkgs_24_05 {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
    in {
      nixosConfigurations = {
        abacusnixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            ./desktop/hardware-configuration.nix
            ./desktop/config.nix
            ({ config, pkgs, lib, ... }: {
              imports = [
                (import ./configuration.nix { inherit config pkgs pkgs_old pkgs_24_05 lib system; machine = "desktop"; })
              ];
            })
          ];
        };
        abacus_nixos_laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            ./laptop/hardware-configuration.nix
            ./laptop/config.nix
            ({ config, pkgs, lib, ... }: {
              imports = [
                (import ./configuration.nix { inherit config pkgs pkgs_old pkgs_24_05 lib system; machine = "laptop"; })
              ];
            })
          ];
        };
      };
    };
}
