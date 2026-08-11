{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  flex,
  glib,
  python3,
  gtk2,
  readline,
  copyDesktopItems,
  makeDesktopItem,
}:

stdenv.mkDerivation rec {
  pname = "gnubg";
  version = "1.08.003";

  src = fetchurl {
    url = "mirror://gnu/gnubg/gnubg-release-${version}-sources.tar.gz";
    hash = "sha256-b32WmxPP/3hvupD/jMXl1WS5f08Kppr+Tzg48YxEWXk=";
  };

  nativeBuildInputs = [
    copyDesktopItems
    pkg-config
    python3
    flex
    glib
  ];

  buildInputs = [
    gtk2
    readline
  ];

  strictDeps = true;

  configureFlags = [
    "--with-gtk"
    "--with--board3d"
  ];

  desktopItems = [
    (makeDesktopItem {
      desktopName = "GNU Backgammon";
      name = pname;
      genericName = "Backgammon";
      comment = meta.description;
      exec = pname;
      icon = pname;
      categories = [
        "Game"
        "GTK"
        "StrategyGame"
      ];
    })
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "World class backgammon application";
    homepage = "https://www.gnu.org/software/gnubg/";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
