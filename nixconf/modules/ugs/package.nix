{
  lib,
  pkgs,
}:
let
  desktopItem = pkgs.makeDesktopItem {
    name = "ugs-platform";
    exec = "ugsplatform";
    comment = "A cross-platform G-Code sender for GRBL, Smoothieware, TinyG and G2core.";
    desktopName = "ugs-platform";
  };

in
pkgs.stdenv.mkDerivation rec {
  pname = "ugs";
  version = "2.1.13";

  src = pkgs.fetchzip {
    url = "https://github.com/winder/Universal-G-Code-Sender/releases/download/v${version}/ugs-platform-app-${version}.zip";
    hash = "sha256-V9hzCrd8mAVPYSEEk2xiD0YVTmf4CTADHFAsFW50m6o=";
  };
  jogl = pkgs.fetchurl {
    url = "https://repo.runelite.net/net/runelite/jogl/jogl-all/2.4.0-rc-20200429/jogl-all-2.4.0-rc-20200429-natives-linux-amd64.jar";
    sha256 = "S60qxyWY9RfyhLFygn/OxZFWnc8qVRtTFdWMbdu+2U0=";
  };
  gluegen = pkgs.fetchurl {
    url = "https://repo.runelite.net/net/runelite/gluegen/gluegen-rt/2.4.0-rc-20200429/gluegen-rt-2.4.0-rc-20200429-natives-linux-amd64.jar";
    sha256 = "eF8S5sQkJFDtW8rcVBKIyeyKm5Ze5rXK5r/yosZcHjU=";
  };
  dontUnpack = true;

  nativeBuildInputs = with pkgs; [
    copyDesktopItems
    makeWrapper
    unzip
  ];

  installPhase = ''
    runHook preInstall


    mkdir -p $out
    mkdir -p $out/natives
    ${pkgs.unzip}/bin/unzip ${jogl}    'natives/*' -d $out
    ${pkgs.unzip}/bin/unzip ${gluegen} 'natives/*' -d $out
    cp -r ${src}/* $out/

    runHook postInstall
  '';

  postFixup = ''
    ln -s $out/etc/ugsplatform.clusters $out/etc/.ugsplatform-wrapped.clusters
    wrapProgram $out/bin/ugsplatform \
      --prefix PATH : ${
        lib.makeBinPath [
          pkgs.jdk
        ]
      } \
      \
      --set LIBGL_ALWAYS_SOFTWARE 1 \
      \
      --set GDK_BACKEND x11 \
      --set _JAVA_AWT_WM_NONREPARENTING 1 \
      \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        pkgs.xorg.libXxf86vm
        pkgs.xorg.libX11
        pkgs.xorg.libXext
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXrender
        pkgs.xorg.libXrandr
        pkgs.xorg.libXfixes
        pkgs.xorg.libX11
        pkgs.xorg.libXxf86vm
        pkgs.xorg.libXrender
        pkgs.xorg.libXext
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXrandr
        pkgs.xorg.libXfixes
        pkgs.xorg.libxcb
        pkgs.xorg.libXau
        pkgs.xorg.libXdmcp
        pkgs.gsettings-desktop-schemas
        pkgs.gtk3
        pkgs.mesa
        pkgs.hicolor-icon-theme
      ]} \
      --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib \
      --prefix LD_LIBRARY_PATH : $out/natives/linux-amd64/ \
      --prefix JAVA_LIBRARY_PATH : $out/natives/linix-amd64/ \
  '';

  desktopItems = [ desktopItem ];

  meta = with lib; {
    description = "Cross-platform G-Code sender for GRBL, Smoothieware, TinyG and G2core";
    homepage = "https://github.com/winder/Universal-G-Code-Sender";
    maintainers = with maintainers; [ matthewcroughan ];
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = "ugsplatform";
  };
}
