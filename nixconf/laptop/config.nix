{config, pkgs, lib, ... }: {
    networking.hostName = "abacus_nixos_laptop";

    bluetooth.enable = true;
    ctf.enable = true;
    viennabc.enable = false;
}
