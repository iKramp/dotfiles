# sudo stow -R .
# sudo stow -R nixconf -t /etc/nixos
stow -R home
stow -R .config -t ~/.config
stow -R .local -t ~/.local
stow -R Pictures -t ~/Pictures
