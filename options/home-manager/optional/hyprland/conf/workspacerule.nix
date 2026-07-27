{homes, ...}: let
  close =
    if homes.notify == "dunst"
    then "hl.exec_cmd('dunstctl close-all')"
    else if homes.notify == "swaync"
    then "hl.exec_cmd('swaync-client --hide-all')"
    else "";
in {
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

        -- auto toggle gamemode
        local gamemode_enabled = false
        hl.on("workspace.active", function(ws)
            if ws.id == 7 then
                if not gamemode_enabled then
                    hl.exec_cmd("~/.config/qmk/crkbd-toggle-game.py 1")
                    require("lib.util").gamemode("enable")
                    ${close}
                    hl.exec_cmd('notify-send -e -a nosound -i state_running "Game Mode" "Activated"')
                    gamemode_enabled = true
                end
            else
                if gamemode_enabled then
                    hl.exec_cmd("~/.config/qmk/crkbd-toggle-game.py 0")
                    require("lib.util").gamemode("disable")
                    ${close}
                    hl.exec_cmd('notify-send -e -a nosound -i state_paused "Game Mode" "Deactivated"')
                    gamemode_enabled = false

                    hl.on("workspace.removed", function()
                        require("lib.util").gamemode("vfr")
                    end)
                end
            end
        end)
      '';
    };
  };
}
