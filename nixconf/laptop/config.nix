{config, pkgs, lib, ... }: {
    networking.hostName = "abacus_nixos_laptop";

    bluetooth.enable = true;
    # nvidia.enable = true;
    ctf.enable = true;
}
