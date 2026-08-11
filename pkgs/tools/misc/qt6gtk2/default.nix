{
  fetchFromGitLab,
  lib,
  stdenv,
  gtk2,
  pkg-config,
  qmake,
  qtbase,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "qt6gtk2";
  version = "0.6";

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "trialuser";
    repo = "qt6gtk2";
    tag = finalAttrs.version;
    hash = "sha256-RJybIm0HllnYaPfsnci+9ZCGvvL9F2MC7dDbiK+L7bU=";
  };

  buildInputs = [
    gtk2
    qtbase
  ];
  nativeBuildInputs = [
    pkg-config
    qmake
  ];

  dontWrapQtApps = true;

  qmakeFlags = [
    "PLUGINDIR=${placeholder "out"}/${qtbase.qtPluginPrefix}"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "GTK+2.0 integration plugins for Qt6";
    license = lib.licenses.gpl2Plus;
    homepage = "https://www.opencode.net/trialuser/qt6gtk2";
    maintainers = [ lib.maintainers.misterio77 ];
    platforms = lib.platforms.linux;
  };
})
