{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-24.11";
    hardware-config = { url = "path:/etc/nixos/hardware-configuration.nix"; flake = false; };
  };

  outputs = { self, nixpkgs, nixpkgs_old, hardware-config }@inputs: 
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
      hardware_config = import hardware-config;
    in {
      nixosConfigurations = {
        abacusnixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            hardware_config
            ./desktop/config.nix
            ({ config, pkgs, lib, ... }: {
              imports = [
                (import ./configuration.nix { inherit config pkgs pkgs_old lib system; machine = "desktop"; })
              ];
            })
          ];
        };
        abacus_nixos_laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
          };
          modules = [
            hardware_config
            ./laptop/config.nix
            ({ config, pkgs, lib, ... }: {
              imports = [
                (import ./configuration.nix { inherit config pkgs pkgs_old lib system; machine = "laptop"; })
              ];
            })
          ];
        };
      };
    };
}
