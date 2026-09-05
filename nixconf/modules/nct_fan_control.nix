{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.nctFanControl;
in
{
  options.nctFanControl = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Configuration for controlling fans using a NCT driver
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [ "nct6775" ];
    environment.systemPackages = [
      pkgs.lm_sensors # for fan control
    ];

    programs.coolercontrol.enable = true;

    # systemd.services.nct6775-pwm-control = {
    #   description = "Enable manual PWM control for NCT6799 fans";
    #
    #   wantedBy = [ "multi-user.target" ];
    #   after = [ "systemd-modules-load.service" ];
    #
    #   serviceConfig = {
    #     Type = "oneshot";
    #   };
    #
    #   script = ''
    #     for hwmon in /sys/class/hwmon/hwmon*; do
    #       if [ "$(cat "$hwmon/name" 2>/dev/null)" = "nct6799" ]; then
    #         echo 1 > "$hwmon/pwm1_enable"
    #         echo 1 > "$hwmon/pwm2_enable"
    #         echo 1 > "$hwmon/pwm3_enable"
    #         echo 1 > "$hwmon/pwm4_enable"
    #         echo 1 > "$hwmon/pwm7_enable"
    #         exit 0
    #       fi
    #     done
    #
    #     echo "nct6799 hwmon device not found" >&2
    #     exit 1
    #   '';
    # };
    #
    # systemd.services.coolercontrold.after = [ "nct6775-pwm-control.service" ];
    # systemd.services.coolercontrold.requires = [ "nct6775-pwm-control.service" ];

  };
}
