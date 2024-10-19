{config, pkgs, lib, options, ... }: 
lib.mkIf (options.networking.hostName == "abacus_nixos_laptop") {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    environment.systemPackages = [];
}
