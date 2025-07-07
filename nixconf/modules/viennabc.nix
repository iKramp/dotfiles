{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.viennabc;
in {
    options.viennabc = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Packages for the bootcamp
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          volatility3
          autopsy
        ];
    };
}
