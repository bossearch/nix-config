{
  lib,
  stdenv,
  fetchurl,
  rpmextract,
  makeWrapper,
  gtk3,
  gtk-sharp-3_0,
  mono,
  ffmpeg,
  librsvg,
  gdk-pixbuf,
}:
stdenv.mkDerivation rec {
  pname = "xdm";
  version = "8.0.29";

  src = fetchurl {
    url = "https://github.com/subhra74/xdm/releases/download/${version}/xdman_gtk-${version}-1.fc36.x86_64.rpm";
    sha256 = "dbb47e7fbd03cc82aa4678886003d56e1d5222ecb4a52a83e0e6461fadc27ea3";
  };

  nativeBuildInputs = [rpmextract makeWrapper gdk-pixbuf.dev];
  buildInputs = [mono gtk3 gtk-sharp-3_0 ffmpeg librsvg gdk-pixbuf];

  unpackPhase = ''
    rpmextract $src
  '';

  installPhase = ''
        runHook preInstall

        mkdir -p $out/opt
        cp -r opt/xdman $out/opt/

        mkdir -p $out/share
        cp -r usr/share/* $out/share/ || true

        mkdir -p $out/lib/gdk-pixbuf-2.0/2.10.0/loaders
        cp -v ${librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so \
           $out/lib/gdk-pixbuf-2.0/2.10.0/loaders/ || true

        ${gdk-pixbuf.dev}/bin/gdk-pixbuf-query-loaders \
          $out/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so \
          > $out/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache

        mkdir -p $out/bin
        cat > $out/bin/xdm <<'EOF'
    #! /usr/bin/env bash
    XDM_BIN="@out@/opt/xdman/xdm-app"

    # Check if XDM is running
    PID=$(pgrep -x xdm-app || true)

    if [ -n "$PID" ]; then
        echo "XDM is already running without a visible window. Restarting..."
        kill -9 "$PID"
        sleep 1
    fi

    exec env \
      GTK_THEME=adw-gtk3 \
      GDK_BACKEND=x11 \
      GTK_USE_PORTAL=1 \
      GDK_PIXBUF_MODULE_FILE=@out@/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      GDK_PIXBUF_MODULEDIR=@out@/lib/gdk-pixbuf-2.0/2.10.0/loaders \
      LD_LIBRARY_PATH=@ldLibraryPath@ \
      PATH=@binPath@ \
      "$XDM_BIN" "$@"
    EOF

        chmod +x $out/bin/xdm

        substituteInPlace $out/bin/xdm \
          --subst-var out \
          --subst-var-by ldLibraryPath "${lib.makeLibraryPath [gtk3 gtk-sharp-3_0 librsvg gdk-pixbuf]}" \
          --subst-var-by binPath "${lib.makeBinPath [ffmpeg mono]}"

        # Fix desktop entry if present
        mkdir -p $out/share/applications
        if [ -f usr/share/applications/xdm-app.desktop ]; then
          sed -i \
            -e "s|^Exec=.*|Exec=${stdenv.shell} -c 'xdm \& ~/.config/waybar/scripts/utility/tray-trigger.sh xdm'|" \
            -e "s|^Icon=.*|Icon=$out/share/icons/hicolor/scalable/apps/xdm.svg|" \
            usr/share/applications/xdm-app.desktop

          mkdir -p $out/share/icons/hicolor/scalable/apps
          cp $out/opt/xdman/xdm-logo.svg $out/share/icons/hicolor/scalable/apps/xdm.svg
          cp usr/share/applications/xdm-app.desktop $out/share/applications/xdm.desktop
          rm -f $out/share/applications/xdm-app.desktop
        fi

        runHook postInstall
  '';

  meta = with lib; {
    description = "Xtreme Download Manager (binary release, wrapped for NixOS with auto-restart wrapper)";
    homepage = "https://github.com/subhra74/xdm";
    license = licenses.gpl2;
    platforms = ["x86_64-linux"];
  };
}
