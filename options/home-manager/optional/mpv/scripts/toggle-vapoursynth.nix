{
  config,
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/toggle-vapoursynth.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")
      local first_load_status_file = "${config.home.homeDirectory}/.cache/${hosts.username}/first-load-status.txt"
      local vapoursynth_status_file = "${config.home.homeDirectory}/.cache/${hosts.username}/vapoursynth-status.txt"
      local check_interval = 5 -- Interval to check FPS, in seconds

      -- Function to load the first_load state from file
      local function load_first_load_status()
        local file = io.open(first_load_status_file, "r")
        if file then
          local status = file:read("*a")
          file:close()
          return (status == "true")
        else
          return false
        end
      end

      -- Function to save the first_load state to file
      local function save_first_load_status(status)
        local file, err = io.open(first_load_status_file, "w")
        if not file then
          mp.msg.error("Failed to open state file for writing: " .. tostring(err))
          return
        end
        file:write(tostring(status))
        file:close()
        mp.msg.info("Saved first_load state: " .. tostring(status))
      end

      -- Function to load Vapoursynth status from file
      local function load_vapoursynth_status()
        local file = io.open(vapoursynth_status_file, "r")
        if file then
          local status = file:read("*a")
          file:close()
          return (status == "true")
        else
          return false
        end
      end

      -- Function to save Vapoursynth status to file
      local function save_vapoursynth_status(status)
        local file, err = io.open(vapoursynth_status_file, "w")
        if not file then
          mp.msg.error("Failed to open Vapoursynth status file for writing: " .. tostring(err))
          return
        end
        file:write(tostring(status))
        file:close()
        mp.msg.info("Saved Vapoursynth status: " .. tostring(status))
      end

      -- Function to update the button
      local function update_button_icon(icon_name, active, badge, tooltip, command)
        mp.commandv(
          "script-message-to",
          "uosc",
          "set-button",
          "toggle_vapoursynth",
          utils.format_json({
            icon = icon_name,
            active = active,
            badge = badge,
            tooltip = tooltip,
            command = command,
          })
        )
      end

      -- Function to check current FPS
      local function get_current_fps()
        local fps = mp.get_property_number("estimated-vf-fps")
        return fps or 0 -- Return 0 if the fps is nil
      end

      -- Function to toggle Vapoursynth
      local function toggle_vapoursynth()
        -- Get the current fps
        local fps = get_current_fps()
        local first_load = load_first_load_status()

        if first_load then
          --		first_load = false
          save_first_load_status(false) -- Save the updated state to file
          update_button_icon(
            "30fps",
            false,
            false,
            "Enable Vapoursynth",
            "script-binding toggle_vapoursynth/toggle_vapoursynth"
          )
        elseif fps > 30 and not first_load then
          mp.command("no-osd vf remove vapoursynth=~~/filters/mvtools.vpy")
          update_button_icon(
            "30fps",
            false,
            false,
            "Enable Vapoursynth",
            "script-binding toggle_vapoursynth/toggle_vapoursynth"
          )
          save_vapoursynth_status(false)
        elseif fps <= 30 and not first_load then
          mp.command("no-osd vf set vapoursynth=~~/filters/mvtools.vpy")
          update_button_icon(
            "60fps",
            true,
            false,
            "Disable Vapoursynth",
            "script-binding toggle_vapoursynth/toggle_vapoursynth"
          )
          save_vapoursynth_status(true)
        end
      end

      local function periodic_vapoursynth_check()
        local fps = get_current_fps()
        local vapoursynth_enabled = load_vapoursynth_status()

        if fps > 30 and not vapoursynth_enabled then
          mp.command("no-osd vf remove vapoursynth=~~/filters/mvtools.vpy")
          mp.msg.info("Vapoursynth filter removed due to high FPS.")
        elseif fps <= 30 and vapoursynth_enabled then
          mp.command("no-osd vf set vapoursynth=~~/filters/mvtools.vpy")
          mp.msg.info("Vapoursynth filter added due to low FPS.")
        end
      end

      -- Run the toggle function initially
      toggle_vapoursynth()
      mp.add_periodic_timer(check_interval, periodic_vapoursynth_check)

      local watch_later_dir = os.getenv("HOME") .. "/.cache/mpv/watch-later"

      -- Function to modify watch-later files
      local function modify_watch_later_files()
        local p = io.popen("ls " .. watch_later_dir)
        for filename in p:lines() do
          local file_path = watch_later_dir .. "/" .. filename
          local file = io.open(file_path, "r")

          -- Check if the file opened successfully
          if not file then
            print("Could not open file: " .. file_path)
            goto continue
          end

          local lines = {}
          for line in file:lines() do
            table.insert(lines, line)
          end
          file:close()

          -- Create a new table to keep only the first and fourth lines
          local new_lines = {}
          if #lines >= 1 then
            table.insert(new_lines, lines[1]) -- Keep the first line
          end
          if #lines >= 4 then
            table.insert(new_lines, lines[4]) -- Keep the fourth line
          end

          -- Write back the modified content
          file = io.open(file_path, "w")
          if not file then
            print("Could not open file for writing: " .. file_path)
            goto continue
          end

          for _, line in ipairs(new_lines) do
            file:write(line .. "\n")
          end
          file:close()

          ::continue::
        end
      end

      local function on_shutdown()
        modify_watch_later_files()
        save_first_load_status(true) -- Save the updated state to file
        save_vapoursynth_status(false)
        --os.execute("~/.config/mpv/script-opts/cleanvapoursynth.sh")
      end

      mp.register_event("shutdown", on_shutdown)

      mp.add_key_binding("U", "toggle_vapoursynth", toggle_vapoursynth)
    '';
  };
}
