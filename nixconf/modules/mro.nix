# {
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#
#     opp_env = {
#       url = "github:omnetpp/opp_env";
#     };
#   };
#
#   outputs = { self, opp_env, ... }: {
#     nixosModules.default = { config, lib, pkgs, ... }:
#       let
#         cfg = config.fri_mro;
#       in {
#         options.fri_mro.enable = lib.mkEnableOption
#           "packages and options for fri mro class";
#
#         config = lib.mkIf cfg.enable {
#           environment.systemPackages = [
#             opp_env.packages.${pkgs.system}.opp_env
#           ];
#         };
#       };
#   };
# }

{ config, lib, pkgs, ... }:
with lib;

let opp_env = builtins.getFlake "github:omnetpp/opp_env/f782889605215f129622908c5ba4e8055d962fb4";
in {
  options.fri_mro = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable packages and options for fri mro class.
      '';
    };
  };

  config = mkIf config.fri_mro.enable {
    environment.systemPackages = [
      opp_env.packages.${pkgs.system}.opp_env-git
    ];
  };
}
