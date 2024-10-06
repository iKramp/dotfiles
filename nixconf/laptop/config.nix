{config, pkgs, lib, options, ... }: {
  lib.mkif options.networking.hostName == "abacus_nixos_laptop" {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  }
}
