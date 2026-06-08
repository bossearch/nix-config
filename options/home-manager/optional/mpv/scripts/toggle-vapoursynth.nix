{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/toggle-vapoursynth.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")

      local vapoursynth_active = false

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

      local function apply_vapoursynth_state()
      	if vapoursynth_active then
      		mp.command("no-osd vf set vapoursynth=~~/filters/mvtools.vpy")
      		update_button_icon(
      			"60fps",
      			true,
      			false,
      			"Disable Vapoursynth",
      			"script-binding toggle_vapoursynth/toggle_vapoursynth"
      		)
      	else
      		mp.command("no-osd vf remove vapoursynth=~~/filters/mvtools.vpy")
      		update_button_icon(
      			"30fps",
      			false,
      			false,
      			"Enable Vapoursynth",
      			"script-binding toggle_vapoursynth/toggle_vapoursynth"
      		)
      	end
      end

      local function toggle_vapoursynth()
      	vapoursynth_active = not vapoursynth_active
      	apply_vapoursynth_state()
      end

      local function on_file_loaded()
      	apply_vapoursynth_state()
      end

      vapoursynth_active = false

      mp.register_event("file-loaded", on_file_loaded)
      mp.add_key_binding(nil, "toggle_vapoursynth", toggle_vapoursynth)
    '';
  };
}
