killall waybar
pkill waybar
sleep 0.2
waybar -c ~/dotfiles/.config/waybar/config.json -s ~/dotfiles/.config/waybar/style.css &
