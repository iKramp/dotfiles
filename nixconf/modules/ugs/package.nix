{
  stdenv,
  lib,
  copyDesktopItems,
  makeDesktopItem,
  makeWrapper,
  fetchzip,
  jdk,
}:
let
  desktopItem = makeDesktopItem {
    name = "ugs-platform";
    exec = "ugsplatform";
    comment = "A cross-platform G-Code sender for GRBL, Smoothieware, TinyG and G2core.";
    desktopName = "ugs-platform";
  };

in
stdenv.mkDerivation rec {
  pname = "ugs";
  version = "2.1.13";

  src = fetchzip {
    url = "https://github.com/winder/Universal-G-Code-Sender/releases/download/v${version}/ugs-platform-app-${version}.zip";
    hash = "sha256-V9hzCrd8mAVPYSEEk2xiD0YVTmf4CTADHFAsFW50m6o=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    copyDesktopItems
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ${src}/* $out/


    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/ugsplatform \
      --prefix PATH : ${lib.makeBinPath [ jdk ]}
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
