{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.fri_rk;
in {
    options.fri_rk = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable packages and options for fri rk class.
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            wireshark
            gns3-gui
            inetutils
            gns3-server
            dynamips
            ubridge
        ];
        security.wrappers.ubridge = {
            source = "/run/current-system/sw/bin/ubridge";
            capabilities = "cap_net_admin,cap_net_raw=ep";
            owner = "root";
            group = "ubridge";
            permissions = "u+rx,g+rx,o+rx";
        };
    };
}
