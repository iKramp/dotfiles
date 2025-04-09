cd ~/dotfiles/nixconf
sudo nix-collect-garbage --delete-older-than 2d
if [[ "$2" == "-uu" ]]; then
    sudo nix flake update
    sudo nixos-rebuild switch --flake ./#"$1" --upgrade
elif [[ "$2" == "-u" ]]; then
    sudo nixos-rebuild switch --flake ./#"$1" --upgrade
else
    sudo nixos-rebuild switch --flake ./#"$1"
fi
sudo nix-store --optimise
