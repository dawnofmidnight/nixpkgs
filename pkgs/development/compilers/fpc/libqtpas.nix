{
  stdenv,
  lib,
  fetchurl,
  qmake,
  qtbase,
  # Not in Qt6 anymore
  qtx11extras ? null,
}:

let
  qtVersion = lib.versions.major qtbase.version;
  # as of 2.0.10 a suffix is being added. That may or may not disappear and then
  # come back, so just leave this here.
  majorMinorPatch = v: builtins.concatStringsSep "." (lib.take 2 (lib.splitVersion v));
in
stdenv.mkDerivation rec {
  pname = "libqtpas";

  # same as lazarus. we cannot inherit since it triggers the meta.problems
  # validation for gtk 2.
  version = "4.4-0";
  src = fetchurl {
    url = "mirror://sourceforge/lazarus/Lazarus%20Zip%20_%20GZip/Lazarus%20${majorMinorPatch version}/lazarus-${version}.tar.gz";
    hash = "sha256-GQ7ce3p7GEMFAslkpF399UGP8Wu8rVwEQjszoJ0izAY=";
  };

  sourceRoot = "lazarus/lcl/interfaces/qt${qtVersion}/cbindings";

  postPatch = ''
    substituteInPlace Qt${qtVersion}Pas.pro \
      --replace 'target.path = $$[QT_INSTALL_LIBS]' "target.path = $out/lib"
  '';

  nativeBuildInputs = [ qmake ];

  buildInputs = [
    qtbase
  ]
  ++ lib.optionals (qtVersion == "5") [
    qtx11extras
  ];

  dontWrapQtApps = true;

  meta = {
    description = "Free Pascal Qt${qtVersion} binding library";
    homepage =
      "https://wiki.freepascal.org/Qt${qtVersion}_Interface"
      + lib.optionalString (qtVersion == "5") "#libqt5pas";
    maintainers = with lib.maintainers; [ sikmir ];
    # below are same as lazarus, but we can't pull directly because it evals
    # into lazarus and pulls meta.problems.
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
  };
}
