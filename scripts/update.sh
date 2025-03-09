sudo nix-collect-garbage --delete-older-than 2d
if [[ "$2" == "-u" ]]; then
    sudo nixos-rebuild switch --flake ~/dotfiles/nixconf/#"$1" --upgrade
else
    sudo nixos-rebuild switch --flake ~/dotfiles/nixconf/#"$1"
fi
sudo nix-store --optimise
