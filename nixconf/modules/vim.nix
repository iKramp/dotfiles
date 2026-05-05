{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.vimInstall;
in
{
  options.vimInstall = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Vim install
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.neovim
      pkgs.fd # used by nvim-treesitter
      pkgs.ripgrep
      pkgs.tree-sitter
    ];
  };
}
