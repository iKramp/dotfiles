{
  fetchurl,
  lib,
  stdenv,
  autoPatchelfHook,
  wrapGAppsHook4,

  alsa-lib,
  at-spi2-atk,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libdrm,
  mesa,
  nspr,
  nss,
  pango,
  udev,
  xorg,
  libxkbcommon,
  libpulseaudio,
  pipewire,
  makeDesktopItem,
  copyDesktopItems,
}:

let
  version = "2026.602.31138";
  channel = "canary";
  pname = "fluxer";

  src = fetchurl {
    url = "https://api.canary.fluxer.app/dl/desktop/${channel}/linux/x64/${version}/tar_gz";
    name = "fluxer-${version}.tar.gz";
    hash = "sha256-IhzEcYaCcClCO/qIYkEo2JsTLEB+K0+cQWCaJO1Zz7A=";
  };
in

stdenv.mkDerivation rec {
  inherit pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook4
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    mesa
    nspr
    nss
    pango
    udev
    libxkbcommon
    libpulseaudio
    pipewire

    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/${pname}
    cp -r ./* $out/opt/${pname}

    mkdir -p $out/bin
    ln -s $out/opt/${pname}/fluxer-canary $out/bin/fluxer

    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp resources/icons/512x512.png \
      $out/share/icons/hicolor/512x512/apps/fluxer.png

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "fluxer";
      desktopName = "Fluxer";
      exec = "fluxer %U";
      icon = "fluxer";
      startupWMClass = "Fluxer";
      categories = [
        "Network"
        "InstantMessaging"
      ];
      mimeTypes = [ "x-scheme-handler/fluxer" ];
    })
  ];

  meta = with lib; {
    description = "A free and open source instant messaging and VoIP chat app built for friends, groups, and communities";
    homepage = "https://fluxer.app";
    license = licenses.agpl3Plus;
    maintainers = [ ];
    platforms = platforms.linux;
    mainProgram = "fluxer";
  };
}
