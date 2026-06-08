{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/uosc-audio-filter.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local script_name = mp.get_script_name()
      mp.utils = require("mp.utils")

      local AUDIO_FILTERS = {
      	{
      		id = "night_mode",
      		title = "Night Mode (Flat & Compressed)",
      		channels = "mono",
      		filter_string = [[lavfi="pan=stereo|c0=FC+LFE+FL+BL+SL|c1=FC+LFE+FR+BR+SR,loudnorm=I=-24:LRA=1:tp=-1:linear=false:dual_mono=true"]],
      	},
      	{
      		id = "cinema_mode",
      		title = "Cinema Mode (Dynamic & Clear Dialogue)",
      		channels = "stereo",
      		filter_string = [[lowshelf=frequency=100:gain=-2.5,dynaudnorm=compress=27.0:gausssize=53]],
      	},
      }

      local states = {}
      for _, filter in ipairs(AUDIO_FILTERS) do
      	states[filter.id] = false
      end

      local function command(str)
      	return string.format("script-message-to %s %s", script_name, str)
      end

      local function apply_audio_filters()
      	local current_filters = mp.get_property_native("af", {})
      	local clean_filters = {}
      	local target_channels = "auto"

      	for _, filter in ipairs(current_filters) do
      		if filter.label and not filter.label:find("^uosc_custom_") then
      			table.insert(clean_filters, filter)
      		end
      	end

      	mp.set_property_native("af", clean_filters)
      	for _, profile in ipairs(AUDIO_FILTERS) do
      		if states[profile.id] then
      			target_channels = profile.channels
      			local label = "uosc_custom_" .. profile.id
      			mp.commandv("af", "add", "@" .. label .. ":" .. profile.filter_string)
      		end
      	end

      	mp.set_property("audio-channels", target_channels)
      end

      local function create_menu_data()
      	local items = {}

      	for _, filter in ipairs(AUDIO_FILTERS) do
      		items[#items + 1] = {
      			title = filter.title,
      			icon = states[filter.id] and "check_box" or "check_box_outline_blank",
      			value = command("toggle-filter " .. filter.id),
      			keep_open = true,
      		}
      	end

      	return {
      		type = "audio_settings",
      		title = "Audio Filters",
      		items = items,
      	}
      end

      local function update_menu()
      	local json = mp.utils.format_json(create_menu_data())
      	mp.commandv("script-message-to", "uosc", "update-menu", json)
      end

      mp.register_script_message("toggle-filter", function(filter_id)
      	if states[filter_id] ~= nil then
      		local target_state = not states[filter_id]
      		if target_state == true then
      			for id, _ in pairs(states) do
      				states[id] = false
      			end
      		end

      		states[filter_id] = target_state
      		apply_audio_filters()
      		update_menu()
      	end
      end)

      mp.add_key_binding(nil, "open-menu", function()
      	local json = mp.utils.format_json(create_menu_data())
      	mp.commandv("script-message-to", "uosc", "open-menu", json)
      end)
    '';
  };
}
