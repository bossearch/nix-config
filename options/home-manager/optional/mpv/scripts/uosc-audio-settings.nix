{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/uosc-audio-settings.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")

      local script_options = {
      	audio_delay_step = 0.1,
      }

      local script_name = mp.get_script_name()

      mp.utils = require("mp.utils")
      mp.options = require("mp.options")
      mp.options.read_options(script_options, "uosc-audio-settings", function() end)

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

      local default_properties = {
      	["audio-delay"] = mp.get_property_number("audio-delay") or 0.0,
      	["sub-delay"] = mp.get_property_number("sub-delay") or 0.0,
      }

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

      local function create_dual_property_adjustment(title, increment)
      	local current_audio = mp.get_property_number("audio-delay") or 0.0
      	local current_sub = mp.get_property_number("sub-delay") or 0.0

      	local function create_dual_adjustment_actions()
      		return {
      			{
      				name = command("adjust-dual-property " .. increment),
      				icon = "add",
      				label = "Increase both by " .. increment .. ".",
      				keep_open = true,
      			},
      			{
      				name = command("adjust-dual-property -" .. increment),
      				icon = "remove",
      				label = "Decrease both by " .. increment .. ".",
      				keep_open = true,
      			},
      			{
      				name = command("adjust-dual-property reset"),
      				icon = "clear",
      				label = "Reset both values.",
      				keep_open = true,
      			},
      		}
      	end

      	return {
      		id = "adj_dual_audio_sub",
      		title = title,
      		hint = string.format("A: %.2fs | S: %.2fs", current_audio, current_sub),
      		value = command("noop-dual-delay"),
      		actions = create_dual_adjustment_actions(),
      		actions_place = "outside",
      	}
      end

      local menu = {
      	filters = {},
      }

      local function build_filters_menu()
      	menu.filters = {}
      	for _, filter in ipairs(AUDIO_FILTERS) do
      		table.insert(menu.filters, {
      			id = "filter_" .. filter.id,
      			title = filter.title,
      			icon = states[filter.id] and "check_box" or "check_box_outline_blank",
      			value = command("toggle-filter " .. filter.id),
      			keep_open = true,
      		})
      	end
      end

      local function create_menu_list()
      	local items = {}

      	for _, filter_item in ipairs(menu.filters) do
      		table.insert(items, filter_item)
      	end

      	table.insert(items, create_dual_property_adjustment("Audio & sub delay", script_options.audio_delay_step))

      	return {
      		type = "audio_settings",
      		title = "Audio settings",
      		items = items,
      		keep_open = true,
      		callback = { script_name, "menu-event" },
      	}
      end

      local function update_menu()
      	local json = mp.utils.format_json(create_menu_list())
      	mp.commandv("script-message-to", "uosc", "update-menu", json)
      end

      local message_handlers = {
      	["menu-event"] = function(json)
      		local event = mp.utils.parse_json(json)
      		if event.action then
      			mp.command(event.action)
      		elseif event.value then
      			mp.command(event.value)
      		end
      	end,

      	["toggle-filter"] = function(filter_id)
      		if states[filter_id] ~= nil then
      			local target_state = not states[filter_id]
      			if target_state == true then
      				for id, _ in pairs(states) do
      					states[id] = false
      				end
      			end

      			states[filter_id] = target_state
      			apply_audio_filters()
      			build_filters_menu()
      			update_menu()
      		end
      	end,

      	["adjust-dual-property"] = function(value)
      		local num = tonumber(value)
      		if num then
      			local current_audio = mp.get_property_number("audio-delay") or 0.0
      			local current_sub = mp.get_property_number("sub-delay") or 0.0
      			mp.set_property("audio-delay", current_audio + num)
      			mp.set_property("sub-delay", current_sub + num)
      		elseif value == "reset" then
      			mp.set_property("audio-delay", default_properties["audio-delay"])
      			mp.set_property("sub-delay", default_properties["sub-delay"])
      		end
      	end,

      	["noop-dual-delay"] = function() end,
      }

      for name, handler in pairs(message_handlers) do
      	mp.register_script_message(name, handler)
      end

      build_filters_menu()

      mp.observe_property("audio-delay", "number", update_menu)
      mp.observe_property("sub-delay", "number", update_menu)

      mp.add_key_binding(nil, "open-menu", function()
      	local json = mp.utils.format_json(create_menu_list())
      	mp.commandv("script-message-to", "uosc", "open-menu", json)
      end)
    '';
  };
}
