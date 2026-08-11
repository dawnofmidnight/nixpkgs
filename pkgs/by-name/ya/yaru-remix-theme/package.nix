{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  sassc,
  pkg-config,
  glib,
  ninja,
  python3,
  gtk3,
  gnome,
  gnome-themes-extra,
}:

stdenv.mkDerivation rec {
  pname = "yaru-remix";
  version = "40";

  src = fetchFromGitHub {
    owner = "Muqtxdir";
    repo = "yaru-remix";
    rev = "v${version}";
    sha256 = "0xilhw5gbxsyy80ixxgj0nw6w782lz9dsinhi24026li1xny804c";
  };

  nativeBuildInputs = [
    meson
    sassc
    pkg-config
    glib
    ninja
    python3
  ];
  buildInputs = [
    gtk3
    gnome-themes-extra
  ];

  dontDropIconThemeCache = true;

  postPatch = "patchShebangs .";

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Fork of the Yaru GTK theme";
    homepage = "https://github.com/Muqtxdir/yaru-remix";
    license = with lib.licenses; [
      cc-by-sa-40
      gpl3Plus
      lgpl21Only
      lgpl3Only
    ];
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ hoppla20 ];
  };
}
