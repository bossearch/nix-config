{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.workspacerule" = {
      autoLoad = true;
      content = ''
        -----------------------
        ---- WORKSPACERULE ----
        -----------------------

        hl.workspace_rule({ workspace = "special:scratchpad", gaps_out = 200, on_created_empty = "alacritty -T scratchpad" })
        hl.workspace_rule({ workspace = "1", layout = "monocle", on_created_empty = "alacritty" })
        hl.workspace_rule({ workspace = "2", layout = "scrolling", on_created_empty = "firefox" })
        hl.workspace_rule({ workspace = "6", layout = "scrolling" })
        hl.workspace_rule({ workspace = "7", layout = "monocle" })
      '';
    };
  };
}
