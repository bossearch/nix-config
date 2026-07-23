{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/uosc-subtitle-settings.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")

      local options = {
      	pos_increment = 1,
      	scale_increment = 0.05,
      	delay_increment = 0.1,
      }

      local script_name = mp.get_script_name()

      mp.utils = require("mp.utils")
      mp.options = require("mp.options")
      mp.options.read_options(options, "uosc-subtitle-settings", function() end)

      local function command(str)
      	return string.format("script-message-to %s %s", script_name, str)
      end

      -- Store initial default values for the reset action
      local default_properties = {
      	["sub-pos"] = mp.get_property_number("sub-pos"),
      	["sub-scale"] = mp.get_property_number("sub-scale"),
      	["sub-delay"] = mp.get_property_number("sub-delay"),
      }

      local ass_override = mp.get_property("sub-ass-override")
      local blend = mp.get_property("blend-subtitles")

      local function create_property_number_adjustment(title, property, increment, format_str, min, max)
      	local current_value = mp.get_property_number(property) or 0.0

      	local function create_adjustment_actions()
      		local range = ""
      		if min or max then
      			range = " " .. (min or "") .. (max and " " .. max or "")
      		end

      		return {
      			{
      				name = command("adjust-property " .. property .. " " .. increment .. range),
      				icon = "add",
      				label = "Increase by " .. increment .. ".",
      			},
      			{
      				name = command("adjust-property " .. property .. " -" .. increment .. range),
      				icon = "remove",
      				label = "Decrease by " .. increment .. ".",
      			},
      			{
      				name = command("adjust-property " .. property .. " reset"),
      				icon = "clear",
      				label = "Reset.",
      			},
      		}
      	end

      	return {
      		title = title,
      		hint = string.format(format_str, current_value),
      		actions = create_adjustment_actions(),
      		actions_place = "outside",
      	}
      end

      local function create_menu_data()
      	local items = {
      		-- Flattened Position to only handle Primary sub-pos with inline actions
      		create_property_number_adjustment("Position", "sub-pos", options.pos_increment, "%d", 0, 100),
      		create_property_number_adjustment("Scale", "sub-scale", options.scale_increment, "%.2f"),
      		create_property_number_adjustment("Delay", "sub-delay", options.delay_increment, "%.2f s"),
      		{
      			title = "ASS override",
      			items = {
      				{
      					title = "Off",
      					icon = ass_override == "no" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-ass-override off"),
      				},
      				{
      					title = "On",
      					icon = ass_override == "yes" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-ass-override on"),
      				},
      				{
      					title = "Scale",
      					icon = ass_override == "scale" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-ass-override scale"),
      				},
      				{
      					title = "Force",
      					icon = ass_override == "force" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-ass-override force"),
      				},
      				{
      					title = "Strip",
      					icon = ass_override == "strip" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-ass-override strip"),
      				},
      			},
      		},
      		{
      			title = "Blend",
      			items = {
      				{
      					title = "Off",
      					icon = blend == "no" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-blend off"),
      				},
      				{
      					title = "On",
      					icon = blend == "yes" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-blend on"),
      				},
      				{
      					title = "Video",
      					icon = blend == "video" and "radio_button_checked" or "radio_button_unchecked",
      					value = command("adjust-blend video"),
      				},
      			},
      		},
      	}

      	return {
      		type = "subtitle_settings",
      		title = "Subtitle settings",
      		items = items,
      		keep_open = true,
      		callback = { script_name, "menu-event" },
      	}
      end

      local function update_menu()
      	local json = mp.utils.format_json(create_menu_data())
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

      	["adjust-property"] = function(property, value, min, max)
      		min = tonumber(min) or -math.huge
      		max = tonumber(max) or math.huge

      		local num = tonumber(value)
      		if num then
      			local current = mp.get_property_number(property) or 0.0
      			local new = math.max(min, math.min(max, current + num))
      			mp.set_property(property, new)
      		elseif value == "reset" then
      			mp.set_property(property, default_properties[property])
      		else
      			mp.set_property(property, value)
      		end
      	end,

      	["adjust-ass-override"] = function(value)
      		local mapping = { off = "no", on = "yes", scale = "scale", force = "force", strip = "strip" }
      		if mapping[value] then
      			mp.set_property("sub-ass-override", mapping[value])
      		end
      	end,

      	["adjust-blend"] = function(value)
      		local mapping = { off = "no", on = "yes", video = "video" }
      		if mapping[value] then
      			mp.set_property("blend-subtitles", mapping[value])
      		end
      	end,
      }

      for name, handler in pairs(message_handlers) do
      	mp.register_script_message(name, handler)
      end

      -- Efficient native value state observers tracking property cycles safely
      mp.observe_property("sub-pos", "number", update_menu)
      mp.observe_property("sub-scale", "number", update_menu)
      mp.observe_property("sub-delay", "number", update_menu)
      mp.observe_property("sub-ass-override", "string", function(_, value)
      	ass_override = value
      	update_menu()
      end)
      mp.observe_property("blend-subtitles", "string", function(_, value)
      	blend = value
      	update_menu()
      end)

      -- Open Menu Keybinding
      mp.add_forced_key_binding(nil, "open-menu", function()
      	local json = mp.utils.format_json(create_menu_data())
      	mp.commandv("script-message-to", "uosc", "open-menu", json)
      end)
    '';
  };
}
