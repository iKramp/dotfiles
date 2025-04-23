# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs_old, pkgs_24_05, lib, machine, system, ... }:

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
    kernelPackages = pkgs_24_05.linuxPackages;
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

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-nord
    ];
    fcitx5.waylandFrontend= true;
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

 hardware.graphics = {
   enable = true;
   extraPackages = [ pkgs_24_05.amdvlk ];
   enable32Bit = true;
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
    videoDrivers = [
      "amdgpu"
      "nvidia"
    ];
  };
  hardware.nvidia.open = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.udisks2.enable = true;

  services.blueman.enable = true;

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
    (rofi-wayland.override {
      plugins = [ pkgs.rofi-calc ];
    })
    waybar

    zip
    unzip

    rustup
    crate2nix

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
    mokuro
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
    gimp
    feh
    xdg-utils
    llvmPackages_17.libllvm
    qemu
    btop
    swaynotificationcenter
    mpv
    krita
    feh
    udiskie
    SDL2
    nvtopPackages.amd
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

    #CTF
    ghidra
    burpsuite
    postman
    ida-free
    pwntools
    python312Packages.anysqlite
    python312Packages.flask

    #AMD gpu things
    lact
    
    #RK
    wireshark
    gns3-gui
    inetutils
    gns3-server
    dynamips
    ubridge
    
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
    volnoti
    hyprpaper
    vscode-extensions.vadimcn.vscode-lldb.adapter
  ]);

  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

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
      # update = "/home/nejc/dotfiles/scripts/update.sh";
      nconf = "nvim /home/nejc/dotfiles/nixconf/configuration.nix";
      tershell = "cd /home/nejc/programming/Terralistic && nix-shell -p gcc pkg-config SDL2 xorg.libXext xorg.libXi xorg.libXcursor xorg.libXrandr xorg.libXScrnSaver --command 'zsh -c nvim .'";
      devshell = "./result/bin/activate";
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


  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  #make electron apps work
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  virtualisation.docker.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 6666 ];
    settings = {
      PasswordAuthentication = false;
    };
  };
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails.sshd.enabled = true;
  };

  # services.gns3-server = {
  #   enable = true;
  #   ubridge.enable = true;
  #   dynamips.enable = true;
  # };
  security.wrappers.ubridge = {
    source = "/run/current-system/sw/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+rx,o+rx";
  };

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
