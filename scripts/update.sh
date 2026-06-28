cd ~/dotfiles/nixconf || exit 1

if [[ "$2" == "-uu" ]]; then
    echo "deprecated option -uu, use -u instead"
    exit 1
fi

last_clean_file=~/dotfiles/last_clean
last_clean=0

if [[ -f "$last_clean_file" ]]; then
    last_clean=$(date -r "$last_clean_file" +%s)
fi

now=$(date +%s)
one_day=$((24 * 60 * 60))

if (( now - last_clean > one_day )); then
    if sudo nix-collect-garbage --delete-older-than 2d; then
        touch "$last_clean_file"
    fi
fi

if [[ "$2" == "-u" ]]; then
    sudo nix flake update || exit 1
fi

sudo nixos-rebuild switch --flake ./#"$1" -vv
rebuild_status=$?

if (( rebuild_status == 0 )); then
    sudo nix-store --optimise
fi

exit "$rebuild_status"
