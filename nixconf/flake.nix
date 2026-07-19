{
  description = "My nixos config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/d407951447dcd00442e97087bf374aad70c04cea";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs_25_11.url = "github:nixos/nixpkgs/nixos-25.11";
    millennium.url = "git+https://github.com/michaelgoldenn/Millennium";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_old,
      nixpkgs_25_11,
      millennium,
    }:
    let
      overlays = [
        millennium.overlays.default
        (final: prev: {
          fluxer = prev.callPackage ./pkgs/fluxer.nix { };
        })
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system overlays;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      pkgs_old = import nixpkgs_old {
        inherit system overlays;
        config = {
          allowUnfree = true;
          allowBroken = true;
          permittedInsecurePackages = [
            "electron-39.8.10"
          ];
        };
      };
      pkgs_25_11 = import nixpkgs_25_11 {
        inherit system overlays;
        config = {
          allowUnfree = true;
          allowBroken = true;
          permittedInsecurePackages = [
            "electron-39.8.10"
          ];
        };
      };
    in
    {
      nixosConfigurations = {
        abacusnixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs_old pkgs_25_11;
            machine = "desktop";
          };
          modules = [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };
            }
            ./desktop/hardware-configuration.nix
            ./desktop/config.nix
            ./modules/modules.nix
            ./configuration.nix
          ];
        };
        abacus_nixos_laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs_old pkgs_25_11;
            machine = "desktop";
          };
          modules = [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };
            }
            ./laptop/hardware-configuration.nix
            ./laptop/config.nix
            ./modules/modules.nix
            ./configuration.nix
          ];
        };
      };
    };
}
