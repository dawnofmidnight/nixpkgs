{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  libxdmcp,
  libexif,
  libfm,
  libpthread-stubs,
  libxcb,
  lxqt-build-tools,
  lxqt-menu-data,
  menu-cache,
  pkg-config,
  qttools,
  wrapQtAppsHook,
  gitUpdater,
  version ? "2.4.0",
  qtx11extras ? null,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libfm-qt";
  inherit version;

  src = fetchFromGitHub {
    owner = "lxqt";
    repo = "libfm-qt";
    tag = finalAttrs.version;
    hash =
      {
        "1.4.0" = "sha256-QxPYSA7537K+/dRTxIYyg+Q/kj75rZOdzlUsmSdQcn4=";
        "2.4.0" = "sha256-gfyskv/TpAdBES0+O1MrrkQqTDqtAGtDMIwv3NF7pnE=";
      }
      ."${finalAttrs.version}";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    lxqt-build-tools
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    libxdmcp
    libexif
    libfm
    libpthread-stubs
    libxcb
    lxqt-menu-data
    menu-cache
  ]
  ++ (lib.optionals (lib.versionAtLeast "2.0.0" finalAttrs.version) [ qtx11extras ]);

  passthru.updateScript = gitUpdater { };

  postPatch = lib.optionals (version == "1.4.0") ''
    substituteInPlace CMakeLists.txt \
      --replace-fail "cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)" "cmake_minimum_required(VERSION 3.10)"
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/lxqt/libfm-qt";
    description = "Core library of PCManFM-Qt (Qt binding for libfm)";
    license = lib.licenses.lgpl21Plus;
    platforms = lib.platforms.unix;
    teams = [ lib.teams.lxqt ];
  };
})
