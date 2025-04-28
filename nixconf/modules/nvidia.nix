{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.nvidia;
in {
    options.nvidia = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable nvidia additional packages.
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            nvtopPackages.nvidia
        ];

        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;

            open = false;
            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };
}
