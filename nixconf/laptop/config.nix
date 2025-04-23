{config, pkgs, lib, ... }: {
    networking.hostName = "abacus_nixos_laptop";
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;
        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    environment.systemPackages = [];

    services.thermald.enable = true;
    services.power-profiles-daemon.enable = true;

    services.logind.extraConfig = ''
      HandleLidSwitch=suspend
      HandleLidSwitchDocked=suspend
  '';
}
