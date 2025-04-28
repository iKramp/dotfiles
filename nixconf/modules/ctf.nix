{ config, lib, pkgs, ... }:
with lib; 

let
    cfg = config.ctf_challenges;
in {
    options.ctf_challenges = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                Enable packages for ctf challanges support.
            '';
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            ghidra
            burpsuite
            postman
            ida-free
            pwntools
        ];
    };
}
