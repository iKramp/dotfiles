{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.amdgpu;
in
{
  options.amdgpu = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable amdgpu additional packages.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lact
      nvtopPackages.amd
    ];

    services.xserver.videoDrivers = [ "amdgpu" ];

    systemd.packages = [ pkgs.lact ];
    systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  };
}
