{pkgs, machine}: 
let packages = with pkgs; [
    prismlauncher
];
in if machine == "dekstop" then
    builtins.trace "Returning packages for desktop" packages
  else []
