{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.virtualbox;
in
{
  options.virtualbox = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable virtualbox emulation
      '';
    };
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "nejc" ];
  };
}
