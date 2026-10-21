{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "abacus_nixos_laptop";

  bluetooth.enable = true;
  ctf.enable = true;
  viennabc.enable = false;
  fri_mro.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
    bluez
    networkmanagerapplet
    brightnessctl
    mono
    powertop
  ];
}
