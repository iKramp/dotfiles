{
  config,
  lib,
  pkgs,
  pkgs_old,
  hyprshutdown,
  ...
}:
with lib;

let
  cfg = config.desktop;
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
        qt6.qtdeclarative #needed for writing config

        swayosd
        
        hyprlock
        hyprpicker
        hyprpaper
        hyprshutdown.packages.${pkgs.system}.default
        hypridle
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
