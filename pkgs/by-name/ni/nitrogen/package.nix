{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  glib,
  gtkmm2,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "nitrogen";
  version = "1.6.1";

  src = fetchurl {
    url = "http://projects.l3ib.org/nitrogen/files/nitrogen-${finalAttrs.version}.tar.gz";
    sha256 = "0zc3fl1mbhq0iyndy4ysmy8vv5c7xwf54rbgamzfhfvsgdq160pl";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    glib
    gtkmm2
  ];

  patchPhase = ''
    patchShebangs data/icon-theme-installer
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Wallpaper browser and setter for X11";
    longDescription = ''
      nitrogen is a lightweight utility that can set the root background on X11.
      It operates independently of any desktop environment, and supports
      multi-head with Xinerama. Wallpapers are browsable with a convenient GUI,
      and settings are stored in a human-readable config file.
    '';
    homepage = "https://github.com/l3ib/nitrogen";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.auntie ];
    mainProgram = "nitrogen";
  };
})
