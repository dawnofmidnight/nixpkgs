{
  atk,
  buildFHSEnv,
  cairo,
  dpkg,
  gdk-pixbuf,
  glib,
  gtk2-x11,
  makeWrapper,
  pango,
  lib,
  stdenv,
  libx11,
}:

{
  src,
  toolName,
  version,
  ...
}@attrs:
let
  wrapBinary = libPaths: binaryName: ''
    wrapProgram "$out/bin/${binaryName}" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath libPaths}"
  '';
  pkg = stdenv.mkDerivation rec {
    inherit (attrs) version src;

    name = "${toolName}-${version}";

    meta =

      {
        homepage = "http://bitscope.com/software/";
        sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
        license = lib.licenses.unfree;
        platforms = [ "x86_64-linux" ];
        problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
      }
      // (attrs.meta or { });

    nativeBuildInputs = [
      makeWrapper
      dpkg
    ];

    libs =
      attrs.libs or [
        atk
        cairo
        gdk-pixbuf
        glib
        gtk2-x11
        pango
        libx11
      ];

    dontBuild = true;

    unpackPhase =
      attrs.unpackPhase or ''
        dpkg-deb -x ${attrs.src} ./
      '';

    installPhase =
      attrs.installPhase or ''
        mkdir -p "$out/bin"
        cp -a usr/* "$out/"
        ${(wrapBinary libs) attrs.toolName}
      '';
  };
in
buildFHSEnv {
  pname = attrs.toolName;
  inherit (attrs) version;
  runScript = "${pkg.outPath}/bin/${attrs.toolName}";
}
// {
  inherit (pkg) meta name;
}
