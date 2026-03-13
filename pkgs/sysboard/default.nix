{
  lib,
  stdenv,
  fetchFromGitHub,
  gtkmm4,
  gtk4-layer-shell,
  pkg-config,
  wrapGAppsHook4,
  wayland-scanner,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sysboard";
  version = "9.9.9";

  src = fetchFromGitHub {
    owner = "System64fumo";
    repo = "sysboard";
    rev = "1a032fb4dd76f3f5496955d293eab2ea90f7fc15";
    sha256 = "sha256-wSx1YyzZvcuCscSSQi+nrvvIh0iFjLDQgnBXN80KfFU=";
  };
  postPatch = ''
    substituteInPlace Makefile \
      --replace-fail pkg-config ''${PKG_CONFIG}
    substituteInPlace src/main.cpp \
      --replace-fail /usr/share/sys64/board/config.conf $out/share/sys64/board/config.conf
    substituteInPlace src/window.cpp \
      --replace-fail /usr/share/sys64/board/style.css $out/share/sys64/board/style.css
  '';
  nativeBuildInputs = [pkg-config wayland-scanner wrapGAppsHook4];
  buildInputs = [gtkmm4 gtk4-layer-shell];

  configurePhase = ''
    runHook preConfigure
    echo '#define GIT_COMMIT_MESSAGE "${finalAttrs.src.rev}"' >> src/git_info.hpp
    echo '#define GIT_COMMIT_DATE "${lib.removePrefix "0-unstable-" finalAttrs.version}"' >> src/git_info.hpp
    runHook postConfigure
  '';

  makeFlags = [
    "DESTDIR=${placeholder "out"}"
    "PREFIX="
  ];

  postInstall = ''
    wrapProgram $out/bin/sysboard --prefix LD_LIBRARY_PATH : $out/lib
  '';

  meta = with lib; {
    description = "Simple virtual keyboard for Wayland";
    homepage = "https://github.com/System64fumo/sysboard";
    license = licenses.wtfpl;
    platforms = platforms.linux;
  };
})
