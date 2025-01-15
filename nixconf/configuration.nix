# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, machine, system, ... }:

let
in {
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
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "1i2fhjys1f7vapzjqf3k8f3068cbrin60cdfni827cajk2sl42mb";
    }) {
      config.allowUnfree = true;
      inherit system;
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config = {
    permittedInsecurePackages = [ 
    "qtwebkit-5.212.0-alpha4"
    "openssl-1.1.1w"];
  };

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
    xkb.layout = "us";
    xkb.variant = "";
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

  services.udisks2.enable = true;

  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nejc = {
    isNormalUser = true;
    description = "Nejc";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    unstable.neovim
    kitty
    firefox
    lf
    rofi-wayland
    wofi
    waybar
    
    cargo
    crate2nix

    spotify
    steam
    stow
    nautilus
    wireplumber
    pipewire
    vlc
    spacedrive
    git
    pavucontrol
    playerctl
    (discord.override {
        withVencord = true;
    })
    unzip
    neofetch
    wl-clipboard
    grim
    slurp
    grimblast
    oh-my-zsh
    libgcc
    python3
    libclang
    libstdcxx5
    gcc
    cmake
    gnumake
    gdb
    libpkgconf
    lua-language-server
    ripgrep
    unstable.obs-studio
    tmux
    ntfs3g
    nvd
    gimp
    feh
    xdg-utils
    llvmPackages_17.libllvm
    qemu
    hyprpaper
    btop
    swaynotificationcenter
    volnoti
    unstable.hyprpicker
    mpv
    krita
    feh
    udiskie
    SDL2
    nvtopPackages.amd
    vscode-extensions.vadimcn.vscode-lldb.adapter
    zathura
    texliveFull
    wtype
    tree-sitter
    texlab
    jdt-language-server
    libisoburn
    (limine.override {
      enableAll = true;
    })
    xxd
    logisim-evolution
    nasm
    unstable.cliphist
    bitwarden
    hyprlock
    ghc
    haskell-language-server
    elf2uf2-rs
    gnome-calculator
    nodejs_22 # needed for the copilot vim plugin
    zig
    zls # zig language server
    wlogout

    #java stuff
    jdk
    maven
  ] ++ (
    import ./laptop/packages.nix {inherit pkgs machine;}
  ) ++ (
    import ./desktop/packages.nix {inherit pkgs machine;}
  );

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
      update = "/home/nejc/dotfiles/scripts/update.sh";
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


  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  #make electron apps work
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  virtualisation.docker.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
