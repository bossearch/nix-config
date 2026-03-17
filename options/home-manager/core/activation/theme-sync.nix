{
  config,
  pkgs,
  hosts,
  lib,
  theme,
  monitor,
  ...
}: let
  nvimLuaCmd = lib.concatStringsSep " " [
    "if _G.MiniBase16 then MiniBase16.setup({palette={base00='#${config.colorScheme.palette.base00}',base01='#${config.colorScheme.palette.base01}',base02='#${config.colorScheme.palette.base02}',base03='#${config.colorScheme.palette.base03}',base04='#${config.colorScheme.palette.base04}',base05='#${config.colorScheme.palette.base05}',base06='#${config.colorScheme.palette.base06}',base07='#${config.colorScheme.palette.base07}',base08='#${config.colorScheme.palette.base08}',base09='#${config.colorScheme.palette.base09}',base0A='#${config.colorScheme.palette.base0A}',base0B='#${config.colorScheme.palette.base0B}',base0C='#${config.colorScheme.palette.base0C}',base0D='#${config.colorScheme.palette.base0D}',base0E='#${config.colorScheme.palette.base0E}',base0F='#${config.colorScheme.palette.base0F}'}}) end"
    "if package.loaded['lualine'] then package.loaded['lualine'] = nil require('lualine').setup() end"
  ];
  reloadWallpaper =
    lib.concatMapStringsSep "\n" (m: ''
      ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper "${m.name},$CACHE_DIR/hyprpaper.png"
    '')
    monitor;
in
  pkgs.writeShellScript "theme-sync" ''
    set -euo pipefail
    CACHE_DIR="$HOME/.cache/${hosts.username}"
    mkdir -p "$CACHE_DIR"

    HOST_THEME="${hosts.theme}"
    GOWALL_THEME="${theme}"
    THEME_FILE="$CACHE_DIR/theme"

    if [[ ! -f "$THEME_FILE" ]]; then
      echo "$HOST_THEME" > "$THEME_FILE"
    fi

    OLD_HOST_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "")

    if [[ "$HOST_THEME" != "$OLD_HOST_THEME" ]]; then
      echo "$HOST_THEME" > "$THEME_FILE"

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
          ${pkgs.neovim}/bin/nvim --server "$NVIM_SOCK" --remote-send ":lua ${nvimLuaCmd}<CR>" &
        fi
      done

      OLD_WALL=$(find "$HOME/Pictures/gowall" -maxdepth 1 -type f -name 'wall-*' | sort | tail -n 2 | head -n 1)
      if [[ -f "$OLD_WALL" ]]; then
        ${pkgs.gowall}/bin/gowall convert "$OLD_WALL" -t "$GOWALL_THEME" --output "$CACHE_DIR/hyprpaper.png"
        sleep 2
        ${reloadWallpaper}
      fi

      if [[ -f "$HOME/.config/hypr/scripts/hyprpaper.sh" ]]; then
        bash "$HOME/.config/hypr/scripts/hyprpaper.sh" & disown
      fi
    fi
  ''
