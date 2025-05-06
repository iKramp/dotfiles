{config, pkgs, lib, ... }: {
    networking.hostName = "abacusnixos";

    amdgpu.enable = true;
    ctf.enable = true;

    boot.crashDump.enable = true;
}
