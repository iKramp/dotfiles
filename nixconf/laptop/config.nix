{config, pkgs, lib, ... }: {
    networking.hostName = "abacus_nixos_laptop";
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    environment.systemPackages = [];
}
