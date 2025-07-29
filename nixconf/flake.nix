{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_old,
    }:
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
    in
    {
      nixosConfigurations = {
        abacusnixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system pkgs_old;
            machine = "desktop";
          };
          modules = [
            ./desktop/hardware-configuration.nix
            ./desktop/config.nix
            ./modules/modules.nix
            ./configuration.nix
          ];
        };
        abacus_nixos_laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system pkgs_old;
            machine = "laptop";
          };
          modules = [
            ./laptop/hardware-configuration.nix
            ./laptop/config.nix
            ./modules/modules.nix
            ./configuration.nix
          ];
        };
      };
    };
}
