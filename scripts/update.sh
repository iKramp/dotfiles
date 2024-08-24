sudo nix-collect-garbage --delete-older-than 2d
sudo nixos-rebuild switch --upgrade
sudo nix-store --optimise
