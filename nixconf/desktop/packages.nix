{pkgs, pkgs_mindustry, machine}: 
let packages = with pkgs; [
    prismlauncher
    pkgs_mindustry.mindustry-wayland
    osu-lazer-bin
    # jetbrains.idea
    # maven
];
in if machine == "desktop" then
    builtins.trace "Returning packages for desktop" packages
  else []
