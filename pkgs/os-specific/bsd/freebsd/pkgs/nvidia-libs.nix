{
  mkDerivation,
  nvidia-driver,
  autoPatchelfHook,
  libxext,
  libx11,
  freetype,
  gtk2,
  gtk3,
  cairo,
  pango,
  fontconfig,
  glib,
  libintl,
  libdrm,
  libgbm,
}:
mkDerivation {
  path = "...";
  pname = "nvidia-libs";
  inherit (nvidia-driver) src version;

  extraNativeBuildInputs = [
    autoPatchelfHook
  ];
  buildInputs = [
    libdrm
    libgbm
    gtk2
    gtk3
    cairo
    pango
    fontconfig
    glib
    libintl
    freetype
    libxext
    libx11
  ];

  env.LOCALBASE = "${builtins.placeholder "out"}";
  env.VKICD_PATH = "${builtins.placeholder "out"}/share/vulkan/icd.d";
  env.VKLAYERS_PATH = "${builtins.placeholder "out"}/share/vulkan/implicit_layer.d";
  env.EGL_GLVND_JSON_PATH = "${builtins.placeholder "out"}/share/glvnd/egl_vendor.d";
  env.EGL_EXTERNAL_PLATFORM_JSON_PATH = "${builtins.placeholder "out"}/share/egl/egl_external_platform.d";

  postPatch = ''
    substituteInPlace lib/libGLX_nvidia/Makefile \
      --replace-fail /usr/share/nvidia $out/share/nvidia \
      --replace-fail " '''" ""
  '';

  dontBuild = true;
  installPhase = ''
    make -C lib install
  '';

  meta = {
    problems.removal.message = "GTK 2 has reached end of life and will soon be removed from Nixpkgs. All dependents must be migrated off or dropped. More information can be found in the tracking issue: https://github.com/NixOS/nixpkgs/issues/410814";
  };
}
