{
  lib,
  stdenv,
  fetchurl,
  glib,
  gtk2,
  pkg-config,
  hamlib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "xlog";
  version = "2.0.25";

  src = fetchurl {
    url = "mirror://savannah/xlog/xlog-${finalAttrs.version}.tar.gz";
    hash = "sha256-NYC3LgoLXnJQURcZTc2xHOzOleotrWtOETMBgadf2qU=";
  };

  # glib-2.62 deprecations
  env.NIX_CFLAGS_COMPILE = "-DGLIB_DISABLE_DEPRECATION_WARNINGS -Wno-old-style-definition";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    glib
    gtk2
    hamlib
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Amateur radio logging program";
    longDescription = ''
      Xlog is an amateur radio logging program.
      It supports cabrillo, ADIF, trlog (format also used by tlf),
      and EDI (ARRL VHF/UHF contest format) and can import twlog, editest and OH1AA logbook files.
      Xlog is able to do DXCC lookups and will display country information, CQ and ITU zone,
      location in latitude and longitude and distance and heading in kilometers or miles,
      both for short and long path.
    '';
    homepage = "https://www.nongnu.org/xlog";
    maintainers = [ lib.maintainers.mafo ];
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    mainProgram = "xlog";
    broken = stdenv.hostPlatform.isDarwin;
  };
})
