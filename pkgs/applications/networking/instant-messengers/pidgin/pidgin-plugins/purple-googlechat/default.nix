{
  lib,
  stdenv,
  fetchFromGitHub,
  pidgin,
  glib,
  json-glib,
  protobuf,
  protobufc,
}:

stdenv.mkDerivation {
  pname = "purple-googlechat";
  version = "unstable-2021-10-18";

  src = fetchFromGitHub {
    owner = "EionRobb";
    repo = "purple-googlechat";
    rev = "56ba7f79883eca67d37629d365776f6c0b40abdc";
    sha256 = "sha256-iTYVgYI9+6rqqBl5goeEAXpK8FgHDv0MmPsV/82reWA=";
  };

  nativeBuildInputs = [ protobufc ];
  buildInputs = [
    pidgin
    glib
    json-glib
    protobuf
  ];

  env = {
    PKG_CONFIG_PURPLE_PLUGINDIR = "${placeholder "out"}/lib/purple-2";
    PKG_CONFIG_PURPLE_DATADIR = "${placeholder "out"}/share";
  };

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/EionRobb/purple-googlechat";
    description = "Native Google Chat support for pidgin";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
