{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.ugs;
    ugsPackage = import ./ugs/package.nix {
        inherit lib ;
        stdenv = pkgs.stdenv;
        makeWrapper = pkgs.makeWrapper;
        makeDesktopItem = pkgs.makeDesktopItem;
        jdk = pkgs.jdk;
        fetchzip = pkgs.fetchzip;
        copyDesktopItems = pkgs.copyDesktopItems;
    };
in {
    options.ugs = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable ugs.
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [
            ugsPackage
        ];
    };
}
