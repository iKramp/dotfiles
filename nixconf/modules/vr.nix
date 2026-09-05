{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.vrSetup;
  steam = "${config.xdg.dataHome}/Steam";

  openvrpaths = builtins.toJSON {
    version = 1;
    jsonid = "vrpathreg";

    external_drivers = null;
    config = [ "${steam}/config" ];
    log = [ "${steam}/logs" ];

    runtime = [
      "${pkgs.xrizer}/lib/xrizer"
    ];
  };

  generateOpenvrpaths = pkgs.writeShellScript "generate-openvrpaths" ''
    set -euo pipefail

    config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/openvr"
    config_file="$config_dir/openvrpaths.vrpath"

    mkdir -p "$config_dir"

    cat > "$config_file" <<'EOF'
${openvrpaths}
EOF
  '';
in
{
  options.vrSetup = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable VR setup with necessary packages and configurations.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [

    ];

    services.wivrn.enable = true;
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraProfile = ''
          # Allows Monado/WiVRn to be used
          export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
          # Fixes timezones on VRChat
          unset TZ
        '';
      };
    };
    
    systemd.user.services.openvrpaths = {
      description = "Generate OpenVR paths";

      serviceConfig = {
        Type = "oneshot";
        ExecStart = generateOpenvrpaths;
      };

      wantedBy = [ "default.target" ];
    };
  };
}
