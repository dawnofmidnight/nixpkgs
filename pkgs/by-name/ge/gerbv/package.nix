{
  lib,
  stdenv,
  autoconf,
  automake,
  autoreconfHook,
  cairo,
  fetchFromGitHub,
  gettext,
  gtk2-x11,
  libtool,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gerbv";
  version = "2.10.0";

  src = fetchFromGitHub {
    owner = "gerbv";
    repo = "gerbv";
    tag = "v${finalAttrs.version}";
    hash = "sha256-sr48RGLYcMKuyH9p+5BhnR6QpKBvNOqqtRryw3+pbBk=";
  };

  patches = [
    ./0001-fix-invalid-function-signatures.patch
  ];

  postPatch = ''
    sed -i '/AC_INIT/s/m4_esyscmd.*/${finalAttrs.version}])/' configure.ac
  '';

  nativeBuildInputs = [
    autoconf
    automake
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    (cairo.override { x11Support = true; })
    gettext
    gtk2-x11
    libtool
  ];

  configureFlags = [
    "--disable-update-desktop-database"
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Gerber (RS-274X) viewer";
    mainProgram = "gerbv";
    homepage = "https://gerbv.github.io/";
    changelog = "https://github.com/gerbv/gerbv/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ mog ];
    platforms = lib.platforms.unix;
  };
})
