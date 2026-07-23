{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.keybinding" = {
      autoLoad = true;
      content = ''
        ---------------------
        ---- KEYBINDINGS ----
        ---------------------

        local mainMod = "SUPER"
        local secMod = "CONTROL"
        local meh = "MOD5"
        local hyper = "SUPER + MOD5"

        local terminal = "alacritty"
        local pass = "footclient -T smallfzf ~/.config/fzf/extra/pass.sh password"
        local otp = "footclient -T smallfzf ~/.config/fzf/extra/pass.sh otp"
        local workspace = "~/.config/hypr/scripts/workspace.sh"
        local cycle = "~/.config/hypr/scripts/cycle.sh"
        local util = require("lib.util")

        hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/quit.sh"))
        hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

        hl.bind(mainMod .. " + SPACE", function()
            util.toggle_app("smallfzf", "footclient -T smallfzf ~/.config/fzf/extra/drun.sh")
        end, { release = true })
        hl.bind(secMod .. " + SPACE", function()
            util.toggle_app("smallfzf", "footclient -T smallfzf ~/.config/fzf/extra/run.sh")
        end, { release = true })
        hl.bind(mainMod .. " + code:60", function()
            util.toggle_app("smallfzf", "footclient -T smallfzf ~/.config/fzf/extra/emoji.sh")
        end, { release = true }) -- "."
        hl.bind(mainMod .. " + V", function()
            util.toggle_app("bigfzf", "footclient -T bigfzf ~/.config/fzf/extra/clipboard.sh")
        end, { release = true }) -- "."

        hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/mpv/mpv.sh"))
        hl.bind(mainMod .. " + code:59", hl.dsp.exec_cmd("~/.config/qmk/cheatsheet-wrapper.sh")) -- ","

        -- TODO: remove this key later or update the path if still used
        -- hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprlock.sh"))
        -- hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/word-lookup.sh"))
        -- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/deepl-terjemah.sh"))
        -- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/hypr/scripts/deepl-translate.sh"))
        -- hl.bind(meh .. " + Q", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenshot/ssmonitor.sh"))
        -- hl.bind(hyper .. " + Q", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenrecord/recmonitor.sh"))
        -- hl.bind(meh .. " + W", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenshot/sswindow.sh"))
        -- hl.bind(hyper .. " + W", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenrecord/recwindow.sh"))
        -- hl.bind(meh .. " + E", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenshot/ssarea.sh"))
        -- hl.bind(hyper .. " + E", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenrecord/recarea.sh"))
        -- hl.bind(meh .. " + R", hl.dsp.exec_cmd("~/.config/waybar/scripts/utility/hyprpicker.sh"))
        -- hl.bind(hyper .. " + R", hl.dsp.exec_cmd("~/.config/waybar/scripts/screenshot/ocr.sh"))
        -- hl.bind(meh .. " + V", hl.dsp.exec_cmd("~/.config/waybar/scripts/pavucontrol/cycle-output.sh"))
        -- hl.bind(hyper .. " + V", hl.dsp.exec_cmd("~/.config/waybar/scripts/pavucontrol/cycle-input.sh"))
        -- hl.bind(meh .. " + C", hl.dsp.exec_cmd("~/.config/waybar/scripts/pavucontrol/toggle-output.sh"))
        -- hl.bind(hyper .. " + C", hl.dsp.exec_cmd("~/.config/waybar/scripts/pavucontrol/toggle-input.sh"))
        -- hl.bind(meh .. " + Y", hl.dsp.exec_cmd("~/.config/waybar/scripts/utility/virtualkeyboard.sh"))
        -- hl.bind(
        --     hyper .. " + Y",
        --     hl.dsp.exec_cmd("pgrep sysboard | xargs kill && notify-send 'Virtual Keyboard' 'Off' -i keyboard")
        -- )
        -- hl.bind(hyper .. " + U", hl.dsp.exec_cmd("~/.config/waybar/scripts/hyprsunset/scroll-down.sh"))
        -- hl.bind(meh .. " + I", hl.dsp.exec_cmd("~/.config/waybar/scripts/dunst/dunsticon.sh"))
        -- hl.bind(hyper .. " + I", hl.dsp.exec_cmd("~/.config/waybar/scripts/hyprsunset/scroll-up.sh"))
        -- hl.bind(meh .. " + O", hl.dsp.exec_cmd("hyprctl dispatch setprop active opaque toggle"))
        -- hl.bind(hyper .. " + S", hl.dsp.exec_cmd("~/.config/waybar/scripts/hyprsunset/hyprsunset.sh"))
        -- hl.bind(meh .. " + P", hl.dsp.exec_cmd("pkill smallfzf || hyprctl activewindow -j > /tmp/prev_window && " .. pass))
        -- hl.bind(hyper .. " + P", hl.dsp.exec_cmd("pkill smallfzf || hyprctl activewindow -j > /tmp/prev_window && " .. otp))

        -- Move focus with mainMod + arrow keys
        hl.bind(meh .. " + SPACE", hl.dsp.window.cycle_next({ next = true }))
        hl.bind(meh .. " + J", hl.dsp.exec_cmd(cycle .. " prev"))
        hl.bind(meh .. " + K", hl.dsp.exec_cmd(cycle .. " next"))
        hl.bind(meh .. " + ESCAPE", hl.dsp.exec_cmd("~/.config/hypr/scripts/swap-window.sh"))

        -- Swap window left or right
        hl.bind(hyper .. " + J", hl.dsp.window.swap({ direction = "l" }))
        hl.bind(hyper .. " + K", hl.dsp.window.swap({ direction = "r" }))

        -- Group
        hl.bind(hyper .. " + SPACE", hl.dsp.group.next())
        hl.bind(hyper .. " + ESCAPE", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-group.sh"))

        -- Switch workspaces
        hl.bind(meh .. " + Y", hl.dsp.exec_cmd(workspace .. " focus 1"))
        hl.bind(meh .. " + U", hl.dsp.exec_cmd(workspace .. " focus 2"))
        hl.bind(meh .. " + I", hl.dsp.exec_cmd(workspace .. " focus 3"))
        hl.bind(meh .. " + O", hl.dsp.exec_cmd(workspace .. " focus 4"))
        hl.bind(meh .. " + P", hl.dsp.exec_cmd(workspace .. " focus 5"))

        hl.bind(meh .. " + N", hl.dsp.exec_cmd(workspace .. " focus 6"))
        hl.bind(meh .. " + M", hl.dsp.exec_cmd(workspace .. " focus 7"))
        hl.bind(meh .. " + code:59", hl.dsp.exec_cmd(workspace .. " focus 8"))
        hl.bind(meh .. " + code:60", hl.dsp.exec_cmd(workspace .. " focus 9"))
        hl.bind(meh .. " + code:61", hl.dsp.exec_cmd(workspace .. " focus 10"))

        -- Move active window to a workspace
        hl.bind(hyper .. " + Y", hl.dsp.exec_cmd(workspace .. " move 1"))
        hl.bind(hyper .. " + U", hl.dsp.exec_cmd(workspace .. " move 2"))
        hl.bind(hyper .. " + I", hl.dsp.exec_cmd(workspace .. " move 3"))
        hl.bind(hyper .. " + O", hl.dsp.exec_cmd(workspace .. " move 4"))
        hl.bind(hyper .. " + P", hl.dsp.exec_cmd(workspace .. " move 5"))

        hl.bind(hyper .. " + N", hl.dsp.exec_cmd(workspace .. " move 6"))
        hl.bind(hyper .. " + M", hl.dsp.exec_cmd(workspace .. " move 7"))
        hl.bind(hyper .. " + code:59", hl.dsp.exec_cmd(workspace .. " move 8"))
        hl.bind(hyper .. " + code:60", hl.dsp.exec_cmd(workspace .. " move 9"))
        hl.bind(hyper .. " + code:61", hl.dsp.exec_cmd(workspace .. " move 10"))

        -- Scroll through existing workspaces
        hl.bind(meh .. " + H", hl.dsp.exec_cmd(workspace .. " focus prev"))
        hl.bind(meh .. " + L", hl.dsp.exec_cmd(workspace .. " focus next"))
        hl.bind(meh .. " + mouse_down", hl.dsp.exec_cmd(workspace .. " focus prev"))
        hl.bind(meh .. " + mouse_up", hl.dsp.exec_cmd(workspace .. " focus next"))
        hl.bind(hyper .. " + H", hl.dsp.exec_cmd(workspace .. " move prev"))
        hl.bind(hyper .. " + L", hl.dsp.exec_cmd(workspace .. " move next"))

        -- Special workspace
        hl.bind(meh .. " + RETURN", hl.dsp.workspace.toggle_special("scratchpad"))
        hl.bind(hyper .. " + RETURN", hl.dsp.window.move({ workspace = "special:scratchpad" }))

        -- Toggle Float
        hl.bind(meh .. " + F", hl.dsp.window.float({ action = "toggle" }))
        hl.bind(meh .. " + F", hl.dsp.window.center())

        -- Move/resize windows with mainMod + LMB/RMB and dragging
        hl.bind(meh .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(meh .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

        -- Zoom
        hl.bind(hyper .. " + mouse_down", function()
            util.adjust_zoom(0.5)
        end)
        hl.bind(hyper .. " + mouse_up", function()
            util.adjust_zoom(-0.5)
        end)
        hl.bind(hyper .. " + mouse:272", function()
            hl.config({ cursor = { zoom_factor = 2.0 } })
        end)
        hl.bind(hyper .. " + mouse:273", function()
            hl.config({ cursor = { zoom_factor = 1.0 } })
        end)

        -- Media key
        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
        hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/player-toggle.sh"))
        hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/playerctl.sh"))
        hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/player-seek.sh -5"))
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/player-seek.sh +5"))
        hl.bind(
            "XF86AudioPrev",
            hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/player-skip.sh previous"),
            { long_press = true }
        )
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("~/.config/hypr/scripts/playerctl/player-skip.sh next"), { long_press = true })
      '';
    };
  };
}
