{
  lib,
  stdenv,
  fetchFromGitHub,
  pidgin,
  glib,
  libxml2,
}:

stdenv.mkDerivation {
  pname = "purple-xmpp-upload";
  version = "unstable-2021-11-04";

  src = fetchFromGitHub {
    owner = "Junker";
    repo = "purple-xmpp-http-upload";
    rev = "f370b4a2c474c6fe4098d929d8b7c18aeba87b6b";
    sha256 = "0n05jybmibn44xb660p08vrrbanfsyjn17w1xm9gwl75fxxq8cdc";
  };

  buildInputs = [
    pidgin
    glib
    libxml2
  ];

  installPhase = ''
    install -Dm644 -t $out/lib/purple-2 jabber_http_file_upload.so
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/Junker/purple-xmpp-http-upload";
    description = "HTTP File Upload plugin for libpurple (XMPP Protocol XEP-0363)";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ emmanuelrosa ];
  };
}
