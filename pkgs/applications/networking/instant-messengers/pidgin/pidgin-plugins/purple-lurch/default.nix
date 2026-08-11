{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pidgin,
  minixml,
  libxml2,
  sqlite,
  libgcrypt,
}:

stdenv.mkDerivation rec {
  pname = "purple-lurch";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "gkdr";
    repo = "lurch";
    rev = "v${version}";
    hash = "sha256-yyzotKL1Z4B2BxloJndJKemONMPLG9pVDVe2K5AL05g=";
    fetchSubmodules = true;
  };

  postPatch = ''
    substituteInPlace lib/axc/lib/libsignal-protocol-c/CMakeLists.txt \
      --replace-fail "cmake_minimum_required(VERSION 2.8.4)" "cmake_minimum_required(VERSION 3.10)"
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    pidgin
    minixml
    libxml2
    sqlite
    libgcrypt
  ];

  dontUseCmakeConfigure = true;

  installPhase = ''
    install -Dm755 -t $out/lib/purple-2 build/lurch.so
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/gkdr/lurch";
    description = "XEP-0384: OMEMO Encryption for libpurple";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ emmanuelrosa ];
  };
}
