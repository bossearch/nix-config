{pkgs, ...}: {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.event" = {
      autoLoad = true;
      content = ''
        ---------------
        ---- EVENT ----
        ---------------

        -- enable syshud on fullscreen window
        hl.on("window.fullscreen", function()
            hl.exec_cmd([[
                if hyprctl activewindow | grep -q "fullscreen: 0"; then
                    pkill syshud
                else
                    pgrep -x syshud >/dev/null || ${pkgs.syshud}/bin/syshud -m "0 0 20 0" -T 0 -t 1 &
                fi
            ]])
        end)

        -- auto enable hyprsunset on workspace 1
        local hyprsunset_enabled = false
        hl.on("workspace.active", function(ws)
            if ws.id == 1 then
                if not hyprsunset_enabled then
                    hl.exec_cmd("~/.config/waybar/scripts/control/hyprsunset.sh enable")
                    hyprsunset_enabled = true
                end
            elseif ws.id ~= 1 then
                if hyprsunset_enabled then
                    hl.exec_cmd("~/.config/waybar/scripts/control/hyprsunset.sh disable")
                    hyprsunset_enabled = false
                end
            end
        end)

        -- auto toggle gamemode
        local gamemode_enabled = false
        hl.on("workspace.active", function(ws)
            if ws.id == 7 then
                if not gamemode_enabled then
                    hl.exec_cmd("~/.config/qmk/crkbd-toggle-game.py 1")
                    require("lib.util").gamemode("enable")
                    hl.exec_cmd('dunstctl close-all')
                    hl.exec_cmd('notify-send -e -a game_on -i state_running "Game Mode" "Activated"')
                    gamemode_enabled = true
                end
            else
                if gamemode_enabled then
                    hl.exec_cmd("~/.config/qmk/crkbd-toggle-game.py 0")
                    require("lib.util").gamemode("disable")
                    hl.exec_cmd('dunstctl close-all')
                    hl.exec_cmd('notify-send -e -a game_off -i state_paused "Game Mode" "Deactivated"')
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
