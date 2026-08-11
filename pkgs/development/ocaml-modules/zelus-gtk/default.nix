{
  buildDunePackage,
  zelus,
  lablgtk,
}:

buildDunePackage {
  pname = "zelus-gtk";
  inherit (zelus) version src postPatch;

  minimalOCamlVersion = "4.10";

  nativeBuildInputs = [
    zelus
  ];

  buildInputs = [
    lablgtk
  ];

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
    description = "Zelus GTK library";
    inherit (zelus.meta) homepage license maintainers;
  };
}
