{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.ugs;
    ugsPackage = import ./package.nix {
        inherit lib ;
        pkgs = pkgs;
    };
in {
    options.ugs = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable ugs platform.
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [
            ugsPackage
        ];
    };
}
