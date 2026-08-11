{
  lib,
  stdenv,
  fetchFromGitHub,
  imagemagick,
  gettext,
  pidgin,
  json-glib,
}:

stdenv.mkDerivation {
  pname = "purple-discord";
  version = "unstable-2021-10-17";

  src = fetchFromGitHub {
    owner = "EionRobb";
    repo = "purple-discord";
    rev = "b7ac72399218d2ce011ac84bb171b572560aa2d2";
    sha256 = "0xvj9rdvgsvcr55sk9m40y07rchg699l1yr98xqwx7sc2sba3814";
  };

  nativeBuildInputs = [
    imagemagick
    gettext
  ];
  buildInputs = [
    pidgin
    json-glib
  ];

  env = {
    PKG_CONFIG_PURPLE_PLUGINDIR = "${placeholder "out"}/lib/purple-2";
    PKG_CONFIG_PURPLE_DATADIR = "${placeholder "out"}/share";
  };

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/EionRobb/purple-discord";
    description = "Discord plugin for Pidgin";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ sna ];
  };
}
