{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lib.util" = {
      autoLoad = true;
      content = ''
        --------------
        ---- UTIL ----
        --------------

        local M = {}

        -- workspace
        M.cycle_workspace = function(args)
            local target = (args == "next") and "e+1" or "e-1"
            hl.dispatch(hl.dsp.focus({ workspace = target }))
        end

        M.select_workspace = function(args)
            hl.dispatch(hl.dsp.focus({ workspace = "r~" .. args }))
        end

        -- move window to workspace
        M.move_to_workspace = function(args)
            local target = (args == "next") and "e+1" or "e-1"
            hl.dispatch(hl.dsp.window.move({ workspace = target, follow = true }))
        end

        M.move_to_selected_workspace = function(args)
            hl.dispatch(hl.dsp.window.move({ workspace = "r~" .. args, follow = true }))
        end

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

        -- gamemode
        M.enable_gamemode = function()
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
        end

        M.disable_gamemode = function()
            hl.config({
                decoration = {
                    rounding = 8,
                    active_opacity = 0.9,
                    inactive_opacity = 0.85,
                    blur = {
                        enabled = true,
                    },
                },
            })
        end

        return M
      '';
    };
  };
}
