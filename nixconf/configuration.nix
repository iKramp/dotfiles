# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs_old, lib, machine, system, ... }:

{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      timeout = 100000000;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.useTmpfs = false;
    tmp.tmpfsSize = "50%";
  };

  networking.firewall.enable = false;
  networking.nftables.enable = false;

  nix.settings.experimental-features = ["nix-command" "flakes"];

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
    LC_TIME = "en_US.UTF-8";
  };


  # Add unstable and old nerd fonts
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config = {
    permittedInsecurePackages = [ 
    "qtwebkit-5.212.0-alpha4"
    "openssl-1.1.1w"];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
  ];
  fonts.fontconfig.antialias = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.udisks2.enable = true;

  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x15b7" ATTR{power/wakeup}="disabled"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nejc = {
    isNormalUser = true;
    description = "Nejc";
    extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "libvirt" "ubridge" "wireshark" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;
  users.groups.ubridge = {};


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    neovim
    kitty
    firefox
    lf

    zip
    unzip

    spotify
    steam
    stow
    kdePackages.dolphin
    wireplumber
    pipewire
    vlc
    spacedrive
    git
    gittyup
    pavucontrol
    playerctl
    # (discord.override {
    #     withVencord = true;
    # })
    vesktop
    unzip
    neofetch
    wl-clipboard
    grim
    slurp
    grimblast
    oh-my-zsh
    libgcc
    python312
    python312Packages.gmpy2
    # mokuro #broken because of cython
    clang
    gcc
    clang-tools
    cmake
    gnumake
    gdb
    gdbgui
    libpkgconf
    lua-language-server
    ripgrep
    obs-studio
    tmux
    ntfs3g
    nvd
    gimp3
    feh
    xdg-utils
    llvmPackages_17.libllvm
    btop
    mpv
    krita
    feh
    udiskie
    SDL2
    zathura
    texliveFull
    wtype
    tree-sitter
    texlab
    jdt-language-server
    libisoburn
    xxd
    nasm
    cliphist
    bitwarden
    hyprlock
    hyprpicker
    hyprpolkitagent
    elf2uf2-rs
    nodejs_22 # needed for the copilot vim plugin
    wlogout
    element
    qbittorrent
    thunderbird
    superTuxKart
    ghex
    jq
    libnotify
    glib
    libreoffice
    baobab
    blender
    nil
    nixfmt-rfc-style
    meld
    qpwgraph
    man-pages
    gparted
    docker-compose
    
    ergogen
    kicad-small
    freecad-wayland

    sage

    #ARS
    ripes

    #OIS - html, css, js
    vscode-langservers-extracted # contains css, html, json
    typescript-language-server
    typescript
  ] ++ (
    import ./laptop/packages.nix {inherit pkgs machine;}
  ) ++ (
    import ./desktop/packages.nix {inherit pkgs machine;}
  ) ++ (with pkgs_old; [
    vscode-extensions.vadimcn.vscode-lldb.adapter
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.wireshark.enable = true;
  programs.wireshark.usbmon.enable = true;
  programs.wireshark.dumpcap.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nconf = "nvim /home/nejc/dotfiles/nixconf/configuration.nix";
      tershell = "cd /home/nejc/programming/Terralistic && nix-shell -p gcc pkg-config SDL2 xorg.libXext xorg.libXi xorg.libXcursor xorg.libXrandr xorg.libXScrnSaver --command 'zsh -c nvim .'";
      devshell = "./result/bin/activate";
      buildShell = "nix build ./\#devShells.x86_64-linux.default";
    };
    shellInit = ''
      update() {
        /home/nejc/dotfiles/scripts/update.sh "$@"
      }
    '';
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
  };

  programs.steam.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libgcc
  ];

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 6666 ];
    settings = {
      PasswordAuthentication = false;
    };
  };
  services.fail2ban = {
    enable = false;
    maxretry = 5;
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails.sshd.enabled = true;
  };

  # we don't boot from the internet
  systemd.network.wait-online.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
