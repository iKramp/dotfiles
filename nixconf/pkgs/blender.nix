{ pkgs, ... }:

let
  oldpkgs =
    import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
        sha256 = "0v6bd1xk8a2aal83karlvc853x44dg1n4nk08jg3dajqyy0s98np";
      })
      {
        inherit (pkgs) system;
      };
in
pkgs.symlinkJoin {
  name = "blender-libxml2";
  paths = [ pkgs.blender ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/blender \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [ oldpkgs.libxml2 ]} \
      --prefix NIX_LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [ oldpkgs.libxml2 ]}
  '';
}
