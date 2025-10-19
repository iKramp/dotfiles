{pkgs, pkgs_mindustry, machine}: 
let packages = with pkgs; [
    prismlauncher
    pkgs_mindustry.mindustry-wayland
];
in if machine == "desktop" then
    builtins.trace "Returning packages for desktop" packages
  else []
