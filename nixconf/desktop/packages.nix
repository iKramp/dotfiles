{pkgs, options}: 
let packages = with pkgs; [
  blueman
  bluez
  networkmanagerapplet
  brightnessctl
];
in if options.networking.hostName == "abacusnixos" then
    builtins.trace "Returning packages for hostname: ${options.networking.hostName}" packages
  else
    builtins.trace "Hostname did not match abacus_nixos_laptop (${options.networking.hostName}), returning empty list" []