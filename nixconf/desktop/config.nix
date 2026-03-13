{config, pkgs, lib, ... }: {
    networking.hostName = "abacusnixos";

    amdgpu.enable = true;

    boot.crashDump.enable = true;
    ctf.enable = true;
}
