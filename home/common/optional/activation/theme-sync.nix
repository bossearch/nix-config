{
  config,
  lib,
  theme,
  monitors,
}: let
  reloadWallpaper =
    lib.concatMapStringsSep "\n" (
      m: ''hyprctl hyprpaper wallpaper "${m.name},$CACHE_DIR/hyprpaper.png"''
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
    OLD_WALL=$(find "$HOME/Pictures/gowall" -type f -name "wall-$(date -d 'yesterday' +%Y%m%d).*" | sort | tail -n 1)
    if [[ -f "$OLD_WALL" ]]; then
      gowall convert "$OLD_WALL" -t "$THEME" --output "$CACHE_DIR/hyprpaper.png"
      hyprctl hyprpaper reload ,"$CACHE_DIR/hyprpaper.png"
      ${reloadWallpaper}
    fi

    # Tmux
    if [[ -z "''${SSH_CONNECTION-}" ]]; then
      SOCKET=$(echo "$TMUX" | cut -d',' -f1)
      if tmux -S "$SOCKET" has-session &>/dev/null; then
        tmux -S "$SOCKET" source-file ~/.config/tmux/tmux.conf
      fi
    fi

    # Nvim
    NVIM_SOCK=$(find /run/user/1000 -maxdepth 1 -type s -name 'nvim.*' | head -n 1)
    if [[ -n "$NVIM_SOCK" ]]; then
      nvim --server "$NVIM_SOCK" --remote-send '<C-\><C-N>:ReloadTheme<CR>'
    fi

    # Rerun hyprpaper.sh to generate new wallpaper
    $HOME/.config/hypr/scripts/hyprpaper.sh & disown
  fi
''
