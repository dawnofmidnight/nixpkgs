{
  lib,
  stdenv,
  fetchurl,
  libotr,
  pidgin,
  intltool,
}:

stdenv.mkDerivation rec {
  pname = "pidgin-otr";
  version = "4.0.2";
  src = fetchurl {
    url = "https://otr.cypherpunks.ca/pidgin-otr-${version}.tar.gz";
    sha256 = "1i5s9rrgbyss9rszq6c6y53hwqyw1k86s40cpsfx5ccl9bprxdgl";
  };

  postInstall = "ln -s \$out/lib/pidgin \$out/share/pidgin-otr";

  nativeBuildInputs = [ intltool ];
  buildInputs = [
    libotr
    pidgin
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://otr.cypherpunks.ca/";
    description = "Plugin for Pidgin 2.x which implements OTR Messaging";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
