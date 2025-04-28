{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.bluetooth;
in {
    options.bluetooth = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable Bluetooth support.
            '';
        };
    };

    config = mkIf cfg.enable {
        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
        };

        services.blueman.enable = true;
    };
}
