{
  lib,
  stdenv,
  fetchurl,
  pidgin,
}:

stdenv.mkDerivation rec {
  pname = "pidgin-window-merge";
  version = "0.3";

  src = fetchurl {
    url = "https://github.com/downloads/dm0-/window_merge/window_merge-${version}.tar.gz";
    sha256 = "0cb5rvi7jqvm345g9mlm4wpq0240kcybv81jpw5wlx7hz0lwi478";
  };

  buildInputs = [ pidgin ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/dm0-/window_merge";
    description = "Pidgin plugin that merges the Buddy List window with a conversation window";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
