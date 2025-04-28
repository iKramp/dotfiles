{config, pkgs, lib, ... }: {
    networking.hostName = "abacusnixos";

    amdgpu.enable = true;
}
