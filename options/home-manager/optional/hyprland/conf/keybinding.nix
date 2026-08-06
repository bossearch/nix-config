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
        -- local pass = "footclient -T smallfzf ~/.config/fzf/extra/pass.sh password"
        -- local otp = "footclient -T smallfzf ~/.config/fzf/extra/pass.sh otp"
        local cycle = "~/.config/hypr/scripts/cycle.sh"
        local util = require("lib.util")

        local specialKeys = {
            [","] = "code:59",
            ["."] = "code:60",
            ["/"] = "code:61",
        }

        local function parse_key(key)
            return specialKeys[key] or key
        end

        local workspaceKeys = { "Y", "U", "I", "O", "P", "N", "M", ",", ".", "/" }

        local keybinds = {
            { mod = mainMod, key = "Q", dispatch = "~/.config/hypr/scripts/quit.sh" },
            { mod = mainMod, key = "RETURN", dispatch = terminal },

            -- toggle custom app
            {
                mod = mainMod,
                key = "SPACE",
                dispatch = function()
                    util.toggle_app("smallfzf", "footclient -T smallfzf ~/.config/fzf/extra/drun.sh")
                end,
                opts = { release = true },
            },
            {
                mod = secMod,
                key = "SPACE",
                dispatch = function()
                    util.toggle_app("smallfzf", "footclient -T smallfzf ~/.config/fzf/extra/run.sh")
                end,
                opts = { release = true },
            },
            {
                mod = mainMod,
                key = "V",
                dispatch = function()
                    util.toggle_app("bigfzf", "footclient -T bigfzf ~/.config/fzf/extra/clipboard.sh")
                end,
                opts = { release = true },
            },

            -- cycle focus
            { mod = meh, key = "SPACE", dispatch = hl.dsp.window.cycle_next({ next = true }) },
            { mod = meh, key = "J", dispatch = cycle .. " prev" },
            { mod = meh, key = "K", dispatch = cycle .. " next" },
            { mod = meh, key = "ESCAPE", dispatch = "~/.config/hypr/scripts/swap-window.sh" },

            -- swap window
            { mod = hyper, key = "J", dispatch = hl.dsp.window.swap({ direction = "l" }) },
            { mod = hyper, key = "K", dispatch = hl.dsp.window.swap({ direction = "r" }) },

            -- window groups
            { mod = hyper, key = "SPACE", dispatch = hl.dsp.group.next() },
            { mod = hyper, key = "ESCAPE", dispatch = "~/.config/hypr/scripts/toggle-group.sh" },

            -- Dynamic workspace bindings utilizing the workspaceKeys array
            { mod = meh, key = workspaceKeys, workspace = "focus" },
            { mod = hyper, key = workspaceKeys, workspace = "move" },

            -- scroll through existing workspaces
            { mod = meh, key = "H", dispatch = hl.dsp.focus({ workspace = "e-1" }) },
            { mod = meh, key = "L", dispatch = hl.dsp.focus({ workspace = "e+1" }) },
            { mod = meh, key = "mouse_down", dispatch = hl.dsp.focus({ workspace = "e-1" }) },
            { mod = meh, key = "mouse_up", dispatch = hl.dsp.focus({ workspace = "e+1" }) },
            { mod = hyper, key = "H", dispatch = hl.dsp.window.move({ workspace = "e-1", follow = true }) },
            { mod = hyper, key = "L", dispatch = hl.dsp.window.move({ workspace = "e+1", follow = true }) },

            -- scratchpad
            { mod = meh, key = "RETURN", dispatch = hl.dsp.workspace.toggle_special("scratchpad") },
            { mod = hyper, key = "RETURN", dispatch = hl.dsp.window.move({ workspace = "special:scratchpad" }) },

            -- toggle window
            { mod = meh, key = "F", dispatch = hl.dsp.window.float({ action = "toggle" }) },
            { mod = meh, key = "F", dispatch = hl.dsp.window.center() },

            -- move or drag window
            { mod = meh, key = "mouse:272", dispatch = hl.dsp.window.drag(), opts = { mouse = true } },
            { mod = meh, key = "mouse:273", dispatch = hl.dsp.window.resize(), opts = { mouse = true } },

            -- builtin zoom
            {
                mod = hyper,
                key = "mouse_down",
                dispatch = function()
                    util.adjust_zoom(0.5)
                end,
                opts = { mouse = true },
            },
            {
                mod = hyper,
                key = "mouse_up",
                dispatch = function()
                    util.adjust_zoom(-0.5)
                end,
                opts = { mouse = true },
            },
            {
                mod = hyper,
                key = "mouse:272",
                dispatch = function()
                    hl.config({ cursor = { zoom_factor = 2.0 } })
                end,
                opts = { mouse = true },
            },
            {
                mod = hyper,
                key = "mouse:273",
                dispatch = function()
                    hl.config({ cursor = { zoom_factor = 1.0 } })
                end,
                opts = { mouse = true },
            },

            -- media key
            { mod = "", key = "XF86AudioRaiseVolume", dispatch = "pactl set-sink-volume @DEFAULT_SINK@ +5%" },
            { mod = "", key = "XF86AudioLowerVolume", dispatch = "pactl set-sink-volume @DEFAULT_SINK@ -5%" },
            { mod = "", key = "XF86AudioPlay", dispatch = "~/.config/hypr/scripts/playerctl/player-toggle.sh" },
            { mod = "", key = "XF86AudioMute", dispatch = "~/.config/hypr/scripts/playerctl/playerctl.sh" },
            { mod = "", key = "XF86AudioPrev", dispatch = "~/.config/hypr/scripts/playerctl/player-seek.sh -5" },
            { mod = "", key = "XF86AudioNext", dispatch = "~/.config/hypr/scripts/playerctl/player-seek.sh +5" },
            {
                mod = "",
                key = "XF86AudioPrev",
                dispatch = "~/.config/hypr/scripts/playerctl/player-skip.sh previous",
                opts = { long_press = true },
            },
            {
                mod = "",
                key = "XF86AudioNext",
                dispatch = "~/.config/hypr/scripts/playerctl/player-skip.sh next",
                opts = { long_press = true },
            },

            -- TODO: remove this key later or update the path if still used
            -- { mod = meh, key = "P", dispatch = "pkill smallfzf || hyprctl activewindow -j > /tmp/prev_window && " .. pass },
            -- { mod = hyper, key = "P", dispatch = "pkill smallfzf || hyprctl activewindow -j > /tmp/prev_window && " .. otp },
        }

        for _, bind in ipairs(keybinds) do
            local modBind = bind.mod or mainMod
            local prefix = (modBind ~= "") and (modBind .. " + ") or ""
            local opts = bind.opts or {}

            local bindKey = bind.key
            local keysTable
            if type(bindKey) == "table" then
                keysTable = bindKey
            else
                keysTable = { bindKey }
            end

            local dispatchVal = bind.dispatch

            for i, rawKey in ipairs(keysTable) do
                local combo = prefix .. parse_key(rawKey)

                if bind.workspace == "focus" then
                    hl.bind(combo, hl.dsp.focus({ workspace = "r~" .. i }), opts)
                elseif bind.workspace == "move" then
                    hl.bind(combo, hl.dsp.window.move({ workspace = "r~" .. i, follow = true }), opts)
                elseif dispatchVal then
                    if type(dispatchVal) == "string" then
                        hl.bind(combo, hl.dsp.exec_cmd(dispatchVal), opts)
                    else
                        hl.bind(combo, dispatchVal, opts)
                    end
                end
            end
        end
      '';
    };
  };
}
