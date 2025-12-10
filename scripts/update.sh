cd ~/dotfiles/nixconf
sudo nix-collect-garbage --delete-older-than 2d
if [[ "$2" == "-u" ]]; then
    sudo nix flake update
    sudo nixos-rebuild switch --flake ./#"$1" -vv
else
    sudo nixos-rebuild switch --flake ./#"$1" -vv
fi
sudo nix-store --optimise
