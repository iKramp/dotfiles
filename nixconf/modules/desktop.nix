{
  config,
  lib,
  pkgs,
  pkgs_old,
  ...
}:
with lib;

let
  cfg = config.desktop;
  nixpkgs_smm_pr = builtins.getFlake "github:NixOS/nixpkgs/82da172f855acd214457dff1953f1df1050ce7ae";
in
{
  options.desktop = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable desktop support.
      '';
    };
  };

  config = mkIf cfg.enable {

    assertions = [
      {
        assertion = pkgs.lib.versionOlder pkgs.satisfactorymodmanager.version "3.1.0";
        message = ''
          pkgs.satisfactorymodmanager is now ${pkgs.satisfactorymodmanager.version}.
          Remove the temporary nixpkgs_smm_pr override and switch back to pkgs.satisfactorymodmanager.
        '';
      }
    ];

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-nord
      ];
      fcitx5.waylandFrontend = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
        swaynotificationcenter
        waybar
        (rofi.override {
          plugins = [ pkgs.rofi-calc ];
        })

        quickshell
        qt6.qtdeclarative # needed for writing config

        swayosd

        hyprlock
        hyprpicker
        hyprpaper
        hyprshutdown
        hypridle
        nixpkgs_smm_pr.legacyPackages.${pkgs.system}.satisfactorymodmanager

        jetbrains.idea
        maven
      ]
      ++ (with pkgs_old; [
      ]);

    programs.hyprland.enable = true;
    #make electron apps work
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  };

}
