{
  lib,
  stdenv,
  fetchFromGitHub,
  fftw,
  gtk2,
  libao,
  libsamplerate,
  libsndfile,
  ncurses,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "waon";
  version = "0.11";

  src = fetchFromGitHub {
    owner = "kichiki";
    repo = "waon";
    rev = "v${finalAttrs.version}";
    sha256 = "1xmq8d2rj58xbp4rnyav95y1vnz3r9s9db7xxfa2rd0ilq0ps4y7";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    fftw
    gtk2
    libao
    libsamplerate
    libsndfile
    ncurses
  ];

  installPhase = ''
    install -Dt $out/bin waon pv gwaon
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Wave-to-Notes transcriber";
    homepage = "https://kichiki.github.io/WaoN/";
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.puckipedia ];
    platforms = lib.platforms.all;
  };
})
