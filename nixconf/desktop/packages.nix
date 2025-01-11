{pkgs, options}: 
let packages = with pkgs; [
    modrinth-app
];
in if options.networking.hostName == "abacusnixos" then
    builtins.trace "Returning packages for hostname: ${options.networking.hostName}" packages
  else
    builtins.trace "Hostname did not match abacusnixos (${options.networking.hostName}), returning empty list" []
