{
  config,
  lib,
  theme,
  monitors,
}: let
  reloadWallpaper =
    lib.concatMapStringsSep "\n" (
      m: ''
        hyprctl hyprpaper wallpaper "${m.name},$CACHE_DIR/hyprpaper.png"
      ''
    )
    monitors;
in ''
  export PATH="$HOME/.nix-profile/bin:/run/wrappers/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"

  CACHE_DIR="$HOME/.cache/${config.spec.userName}"
  mkdir -p "$CACHE_DIR"

  THEME="${theme}"
  THEME_FILE="$CACHE_DIR/theme"

  if [[ ! -f "$THEME_FILE" ]]; then
    echo "$THEME" > "$THEME_FILE"
  fi

  OLD_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "")

  if [[ "$THEME" != "$OLD_THEME" ]]; then
    echo "$THEME" >"$THEME_FILE"

    # Hyprpaper
    OLD_WALL=$(find "$HOME/Pictures/gowall" -maxdepth 1 -type f -name 'wall-*' | sort | tail -n 2 | head -n 1)
    if [[ -f "$OLD_WALL" ]]; then
      gowall convert "$OLD_WALL" -t "$THEME" --output "$CACHE_DIR/hyprpaper.png"
      sleep 2
      hyprctl hyprpaper reload ,"$CACHE_DIR/hyprpaper.png"
      ${reloadWallpaper}
    fi

    # Tmux
    if [[ -z "''${SSH_CONNECTION-}" ]]; then
      SOCKET=''${TMUX:+$(echo "$TMUX" | cut -d',' -f1)}
      SOCKET=''${SOCKET:-''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/tmux-$(id -u)/default}
      if tmux -S "$SOCKET" has-session &>/dev/null; then
        tmux -S "$SOCKET" source-file ~/.config/tmux/tmux.conf
      fi
    fi

    # Nvim
    for NVIM_SOCK in /run/user/1000/nvim.*; do
      if [[ -S "$NVIM_SOCK" ]]; then
        nvim --server "$NVIM_SOCK" --remote-send '<C-\><C-N>:ReloadTheme<CR>'
      fi
    done

    # Rerun hyprpaper.sh to generate new wallpaper
    $HOME/.config/hypr/scripts/hyprpaper.sh & disown
  fi
''
