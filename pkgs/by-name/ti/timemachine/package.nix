{
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  gtk2,
  libjack2,
  libsndfile,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "timemachine";
  version = "0.3.4";
  src = fetchFromGitHub {
    owner = "swh";
    repo = "timemachine";
    rev = "v${finalAttrs.version}";
    sha256 = "16fgyw6jnscx9279dczv72092dddghwlp53rkfw469kcgvjhwx0z";
  };

  nativeBuildInputs = [
    pkg-config
    autoconf
    automake
  ];
  buildInputs = [
    gtk2
    libjack2
    libsndfile
  ];

  preConfigure = "./autogen.sh";

  env.NIX_LDFLAGS = "-lm";

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "JACK audio recorder";
    homepage = "http://plugin.org.uk/timemachine/";
    license = lib.licenses.lgpl2;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nico202 ];
    mainProgram = "timemachine";
  };
})
