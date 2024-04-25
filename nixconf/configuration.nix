# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    memtest86.enable = true;
  };
  boot.loader.timeout = 100000000;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "abacus_nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Ljubljana";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };


  # Add unstable and old nerd fonts
  # Allow unfree packages
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {config.allowUnfree = true;};
  };
  nixpkgs.config.allowUnfree = true;

#  hardware.opengl = {
#    enable = true;
#    extraPackages = [ pkgs.unstable.mesa ];
#    driSupport32Bit = true;
#    extraPackages32 = [ pkgs.unstable.pkgsi686Linux.mesa ];
#  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.antialias = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
    videoDrivers = [
      "amdgpu"
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nejc = {
    isNormalUser = true;
    description = "Nejc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    firefox
    lf
    rofi
    wofi
    waybar
    rustup
    spotify
    steam
    stow
    deepin.dde-file-manager
    htop
    wireplumber
    pipewire
    vlc
    unstable.spacedrive
    git
    pavucontrol
    playerctl
    unstable.vesktop
    unzip
    neofetch
    flameshot
    wl-clipboard
    grim
    slurp
    grimblast
    oh-my-zsh
    libgcc
    python3
    libclang
    libstdcxx5
    bear
    gcc
    cmake
    gnumake
    gdb
    libpkgconf
    lua-language-server
    ripgrep
    unstable.obs-studio
    wpsoffice
    tmux
    unstable.osu-lazer-bin
    ntfs3g
    nvd
    gimp
    feh
    xdg-utils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "/home/nejc/Documents/upgrade-nix.sh";
      nconf = "nvim /home/nejc/dotfiles/nixconf/configuration.nix";
      tershell = "cd /home/nejc/programming/Terralistic && nix-shell -p gcc pkg-config SDL2 xorg.libXext xorg.libXi xorg.libXcursor xorg.libXrandr xorg.libXScrnSaver --command 'zsh -c nvim .'";
    };
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
  };

  programs.steam.enable = true;

  #make electron apps work
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
