{
  lib,
  stdenv,
  fetchFromGitHub,
  boost,
  gtkmm2,
  lv2,
  pkg-config,
  python3,
  meson,
  pugl,
  ninja,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "lvtk";
  version = "1.2.0-unstable-2024-11-06";

  src = fetchFromGitHub {
    owner = "lvtk";
    repo = "lvtk";
    rev = "0797fdcabef84f57b064c7b4507743afebc66589";
    hash = "sha256-Z79zy2/OZTO6RTrAqgTHTzB00LtFTFiJ272RvQRpbH8=";
  };

  nativeBuildInputs = [
    pkg-config
    python3
    meson
    ninja
  ];

  buildInputs = [
    boost
    gtkmm2
    lv2
    pugl
  ];

  postInstall = ''
    mv $out/include/lvtk-3.0/lvtk $out/include/
    rmdir $out/include/lvtk-3.0/
  '';

  enableParallelBuilding = true;

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Set C++ wrappers around the LV2 C API";
    homepage = "https://lvtk.org/";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ bot-wxt1221 ];
    platforms = lib.platforms.unix;
    badPlatforms = [
      "aarch64-darwin"
    ];
  };
})
