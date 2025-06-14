{
  config,
  pkgs,
  ...
}: let
  downloadWallpaperScript = pkgs.writeShellScript "fetch-wallpaper" ''
    set -e

    pushd ~/Pictures/gowall >/dev/null || exit

    if ! ping -c 1 1.1.1.1 >/dev/null 2>&1; then
      exit 1
    fi

    DATE=$(date +%Y%m%d)
    INPUT_WALL=$(find . -maxdepth 1 -type f -name "wall-''${DATE}.*" -printf "%f\n" | head -n 1)

    if [ ! -f "$INPUT_WALL" ]; then
      curl -s -A "Mozilla/5.0" 'https://www.reddit.com/r/wallpaper/top/.json?limit=1' |
        jq -r '.data.children[] | select(.data.post_hint == "image") | .data.url' |
        xargs -I {} sh -c 'ext="''${1##*.}"; wget -q -O "wall-$(date +%Y%m%d).$ext" "$1"' _ {}
    fi

    file wall-''${DATE}.* | grep -qE 'image|bitmap' || rm -f wall-''${DATE}.*

    popd >/dev/null || exit
  '';
in {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.bash}/bin/bash -c '${downloadWallpaperScript}; Hyprland >/dev/null'";
        user = "${config.spec.userName}";
      };
      default_session = initial_session;
    };
  };
}
