{
  lib,
  stdenv,
  glibmm,
  pidgin,
  pkg-config,
  modemmanager,
  fetchFromGitLab,
}:

stdenv.mkDerivation rec {
  pname = "purple-mm-sms";
  version = "0.1.7";

  src = fetchFromGitLab {
    domain = "source.puri.sm";
    owner = "Librem5";
    repo = "purple-mm-sms";
    rev = "v${version}";
    sha256 = "0917gjig35hmi6isqb62vhxd3lkc2nwdn13ym2gvzgcjfgjzjajr";
  };

  makeFlags = [
    "DATA_ROOT_DIR_PURPLE=$(out)/share"
    "PLUGIN_DIR_PURPLE=$(out)/lib/purple-2"
  ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    glibmm
    pidgin
    modemmanager
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://source.puri.sm/Librem5/purple-mm-sms";
    description = "Libpurple plugin for sending and receiving SMS via Modemmanager";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
