{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lib.util" = {
      autoLoad = true;
      content = ''
        --------------
        ---- UTIL ----
        --------------

        local M = {}

        -- cycle window with direction (only works for scrolling, master & monocle)
        M.cycle_window = function(layout, direction)
            if layout == "scrolling" then
                local dir = (direction == "next") and "l" or "r"
                hl.dispatch(hl.dsp.layout("focus " .. dir))
            else
                local dir = (direction == "next") and "next" or "prev"
                hl.dispatch(hl.dsp.layout("cycle" .. dir))
            end
        end

        -- toggle functions for keybindings
        M.toggle_app = function(window_identifier, launch_cmd)
            local windows = hl.get_windows()
            for _, w in ipairs(windows) do
                if w.title == window_identifier or w.class == window_identifier then
                    hl.dispatch(hl.dsp.window.close({ window = "address:" .. w.address }))
                    return
                end
            end
            hl.dispatch(hl.dsp.exec_cmd(launch_cmd))
        end

        M.adjust_zoom = function(step)
            local current_zoom = hl.get_config("cursor:zoom_factor")
            local new_zoom = current_zoom + step
            if new_zoom < 1.0 then
                new_zoom = 1.0
            end

            hl.config({
                cursor = {
                    zoom_factor = new_zoom,
                },
            })
        end

        -- swap window
        M.swap_window = function(args, address, id)
            if args == "is_normal" then
                hl.dispatch(hl.dsp.window.swap({ next = true }))
            elseif args == "is_floating" then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. address }))
                hl.dispatch(hl.dsp.window.move({ workspace = "special:hidden", follow = false }))
            elseif args == "is_hidden" then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. address }))
                hl.dispatch(hl.dsp.window.move({ workspace = "r~" .. id }))
            end
        end

        -- toggle group
        M.toggle_group = function(args, var)
            if args == "toggle" then
                hl.dispatch(hl.dsp.group.toggle())
            elseif args == "window" then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. var }))
            elseif args == "move" then
                hl.dispatch(hl.dsp.window.move({ into_group = var }))
            end
        end

        local active_opacity = nil
        local inactive_opacity = nil

        -- toggle opacity
        M.toggle_opacity = function(args)
            if args == "enable" then
                active_opacity = hl.get_config("decoration.active_opacity")
                inactive_opacity = hl.get_config("decoration.inactive_opacity")
                hl.config({
                    decoration = {
                        active_opacity = 1,
                        inactive_opacity = 1,
                    },
                })
            elseif args == "disable" then
                hl.config({
                    decoration = {
                        active_opacity = active_opacity,
                        inactive_opacity = inactive_opacity,
                    },
                })
            end
        end

        -- gamemode
        M.gamemode = function(args)
            if args == "enable" then
                active_opacity = hl.get_config("decoration.active_opacity")
                inactive_opacity = hl.get_config("decoration.inactive_opacity")
                hl.config({
                    decoration = {
                        rounding = 0,
                        active_opacity = 1,
                        inactive_opacity = 1,
                        blur = {
                            enabled = false,
                        },
                    },
                    debug = {
                        vfr = false,
                    },
                })
            elseif args == "disable" then
                hl.config({
                    decoration = {
                        rounding = 8,
                        active_opacity = active_opacity,
                        inactive_opacity = inactive_opacity,
                        blur = {
                            enabled = true,
                        },
                    },
                })
            else
                local ws7_exists = false
                for _, w in ipairs(hl.get_workspaces()) do
                    if w.id == 7 then
                        ws7_exists = true
                        break
                    end
                end

                if not ws7_exists then
                    hl.config({ debug = { vfr = true } })
                end
            end
        end

        return M
      '';
    };
  };
}
