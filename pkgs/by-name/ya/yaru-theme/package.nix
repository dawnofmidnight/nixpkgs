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
  gnome-themes-extra,
  humanity-icon-theme,
  hicolor-icon-theme,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "yaru";
  version = "25.10.3";

  src = fetchFromGitHub {
    owner = "ubuntu";
    repo = "yaru";
    rev = finalAttrs.version;
    hash = "sha256-3cSVPObfmr62S6yTD2c8AO3s7lxb9KFVuYSydTIJ1jE=";
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
  propagatedBuildInputs = [
    humanity-icon-theme
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  postPatch = "patchShebangs .";

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Ubuntu community theme 'yaru' - default Ubuntu theme since 18.10";
    homepage = "https://github.com/ubuntu/yaru";
    license = with lib.licenses; [
      cc-by-sa-40
      gpl3Plus
      lgpl21Only
      lgpl3Only
    ];
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [
      mershl
      moni
    ];
  };
})
