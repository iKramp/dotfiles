{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_old.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs_mindustry.url = "nixpkgs/a19cd4ffb1f4b953a76f3ac29c6520d0b1877108";
    millennium.url = "git+https://github.com/michaelgoldenn/Millennium";
    hyprshutdown.url = "github:hyprwm/hyprshutdown";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_old,
      nixpkgs_mindustry,
      millennium,
      hyprshutdown,
    }:
    let
      overlays = [
        millennium.overlays.default
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
        };
      };
      pkgs_mindustry = import nixpkgs_mindustry {
        inherit system overlays;
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
            inherit system pkgs_old pkgs_mindustry hyprshutdown;
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
            inherit system pkgs_old pkgs_mindustry hyprshutdown;
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
