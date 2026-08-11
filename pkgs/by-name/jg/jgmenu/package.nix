{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  python3Packages,
  pango,
  librsvg,
  libxfce4util,
  libxml2,
  menu-cache,
  libxrandr,
  libxinerama,
  makeWrapper,
  enableXfcePanelApplet ? false,
  xfce4-panel,
  gtk3,
  gitUpdater,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "jgmenu";
  version = "4.6.0";

  src = fetchFromGitHub {
    owner = "jgmenu";
    repo = "jgmenu";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-1Vwzm7DVMwtSZW7GDWEMVPHi09orXlFiKR6XMJ337Dg=";
  };

  nativeBuildInputs = [
    pkg-config
    makeWrapper
    python3Packages.wrapPython
  ];

  buildInputs = [
    pango
    librsvg
    libxml2
    menu-cache
    libxinerama
    libxrandr
    python3Packages.python
  ]
  ++ lib.optionals enableXfcePanelApplet [
    gtk3
    libxfce4util
    xfce4-panel
  ];

  configureFlags = [
  ]
  ++ lib.optionals enableXfcePanelApplet [
    "--with-xfce4-panel-applet"
  ];

  postFixup = ''
    wrapPythonProgramsIn "$out/lib/jgmenu"
    for f in $out/bin/jgmenu{,_run}; do
      wrapProgram $f --prefix PATH : $out/bin
    done
  '';

  passthru.updateScript = gitUpdater { rev-prefix = "v"; };

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    homepage = "https://github.com/jgmenu/jgmenu";
    description = "Small X11 menu intended to be used with openbox and tint2";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.romildo ];
  };
})
