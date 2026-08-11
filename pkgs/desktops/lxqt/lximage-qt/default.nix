{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  libxdmcp,
  libexif,
  libfm-qt,
  libpthread-stubs,
  lxqt-build-tools,
  menu-cache,
  qtbase,
  qtimageformats,
  qtsvg,
  qttools,
  qtwayland,
  wrapQtAppsHook,
  gitUpdater,
}:

stdenv.mkDerivation rec {
  pname = "lximage-qt";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "lxqt";
    repo = "lximage-qt";
    rev = version;
    hash = "sha256-ThP7MuAKysJ/Q/JSO12CuwCt6mCU5tZ2DiKEO0Nfg3U=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    lxqt-build-tools
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    libxdmcp
    libexif
    libfm-qt
    libpthread-stubs
    menu-cache
    qtbase
    qtimageformats # add-on module to support more image file formats
    qtsvg
    qtwayland
  ];

  passthru.updateScript = gitUpdater { };

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/lxqt/lximage-qt";
    description = "Image viewer and screenshot tool for lxqt";
    mainProgram = "lximage-qt";
    license = lib.licenses.gpl2Plus;
    platforms = with lib.platforms; unix;
    teams = [ lib.teams.lxqt ];
  };
}
