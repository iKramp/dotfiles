{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.utils;
in
{
  options.utils = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Utils install
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      file
      checksec
      ripgrep
      xxd
      android-tools
      parted

      zip
      unzip

      nvd # nix package version tool
      jq # json parser
    ];
  };
}
