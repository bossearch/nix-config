{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "notify-send" ''
      ARGS=("$@")
      for arg in "$@"; do
          if [[ "$arg" == "-e" ]]; then
              ARGS+=("-c" "e")
              break
          fi
      done

      exec ${pkgs.libnotify}/bin/notify-send "''${ARGS[@]}"
    '')
  ];
}
