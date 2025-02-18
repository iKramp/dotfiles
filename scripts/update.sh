sudo nix-collect-garbage --delete-older-than 2d
sudo nixos-rebuild switch --flake ~/dotfiles/nixconf/#"$1"
sudo nix-store --optimise
