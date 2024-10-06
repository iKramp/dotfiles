{config, pkgs, lib, options, ... }: 
lib.mkIf (options.networking.hostName == "abacusnixos") {}
