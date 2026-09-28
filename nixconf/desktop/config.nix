{config, pkgs, lib, ... }: {
    networking.hostName = "abacusnixos";

    amdgpu.enable = true;

    boot.crashDump.enable = true;
    ctf.enable = true;
    vrchatTools.enable = true;
    nctFanControl.enable = true;
    vrSetup.enable = true;

    environment.systemPackages = with pkgs; [
        prismlauncher
        osu-lazer-bin
    ];
}
