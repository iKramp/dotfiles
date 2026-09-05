{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.vrchatTools;
in
{
  options.vrchatTools = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Tools for creating vrc content
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.vrc-get
      pkgs.alcom
      pkgs.unityhub
      pkgs.blenderWrapped
    ];
  };
}

