{
  pkgs,
  hosts,
  lib,
  theme,
  monitor,
  ...
}: let
  reloadWallpaper =
    lib.concatMapStringsSep "\n" (m: ''
      ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper "${m.name},$CACHE_DIR/hyprpaper.png"
    '')
    monitor;
in
  pkgs.writeShellScript "theme-sync" ''
    CACHE_DIR="$HOME/.cache/${hosts.username}"
    mkdir -p "$CACHE_DIR"

    THEME="${theme}"
    THEME_FILE="$CACHE_DIR/theme"

    if [[ ! -f "$THEME_FILE" ]]; then
      echo "$THEME" > "$THEME_FILE"
    fi

    OLD_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "")

    if [[ "$THEME" != "$OLD_THEME" ]]; then
      echo "$THEME" > "$THEME_FILE"

      OLD_WALL=$(find "$HOME/Pictures/gowall" -maxdepth 1 -type f -name 'wall-*' | sort | tail -n 2 | head -n 1)

      if [[ -f "$OLD_WALL" ]]; then
        gowall convert "$OLD_WALL" -t "$THEME" --output "$CACHE_DIR/hyprpaper.png"
        sleep 2
        ${pkgs.hyprland}/bin/hyprctl hyprpaper reload ,"$CACHE_DIR/hyprpaper.png"
        ${reloadWallpaper}
      fi

      if [[ -z "''${SSH_CONNECTION-}" ]]; then
        TMUX_BIN="${pkgs.tmux}/bin/tmux"
        SOCKET=''${TMUX:+$(echo "$TMUX" | cut -d',' -f1)}
        SOCKET=''${SOCKET:-''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/tmux-$(id -u)/default}

        if "$TMUX_BIN" -S "$SOCKET" has-session &>/dev/null; then
          "$TMUX_BIN" -S "$SOCKET" source-file "$HOME/.config/tmux/tmux.conf"
        fi
      fi

      for NVIM_SOCK in /run/user/$(id -u)/nvim.*; do
        if [[ -S "$NVIM_SOCK" ]]; then
          ${pkgs.neovim}/bin/nvim --server "$NVIM_SOCK" --remote-send '<C-\><C-N>:ReloadTheme<CR>'
        fi
      done

      if [[ -f "$HOME/.config/hypr/scripts/hyprpaper.sh" ]]; then
        bash "$HOME/.config/hypr/scripts/hyprpaper.sh" & disown
      fi
    fi
  ''
