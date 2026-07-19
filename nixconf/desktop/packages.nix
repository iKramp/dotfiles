{pkgs, machine, ...}: 
let packages = with pkgs; [
    prismlauncher
    osu-lazer-bin
];
in if machine == "desktop" then
    builtins.trace "Returning packages for desktop" packages
  else []
