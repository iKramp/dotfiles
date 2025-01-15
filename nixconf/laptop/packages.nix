{pkgs, machine}: 
let packages = with pkgs; [
  blueman
  bluez
  networkmanagerapplet
  brightnessctl
  mono
];
in if machine == "laptop" then
    builtins.trace "Returning packages for laptop" packages
  else []
