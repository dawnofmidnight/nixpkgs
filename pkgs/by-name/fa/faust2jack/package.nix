{
  bash,
  faust,
  gtk2,
  jack2,
  alsa-lib,
  opencv,
  libsndfile,
  which,
}:

faust.wrapWithBuildEnv {

  baseName = "faust2jack";

  scripts = [
    "faust2jack"
    "faust2jackconsole"
  ];

  buildInputs = [
    bash # required for some scripts
  ];

  propagatedBuildInputs = [
    gtk2
    jack2
    alsa-lib
    opencv
    libsndfile
    which
  ];

  extraMeta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
  };
}
