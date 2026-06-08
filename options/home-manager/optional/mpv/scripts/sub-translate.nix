{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/sub-translate.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")
      local json = require("dkjson")

      local translation_enabled = false
      local target_language = "id"
      local last_sub_start = nil

      local function urlencode(str)
      	if str then
      		str = string.gsub(str, "\n", "\r\n")
      		str = string.gsub(str, "([^%w%-%.%_%~ ])", function(c)
      			return string.format("%%%02X", string.byte(c))
      		end)
      		str = string.gsub(str, " ", "+")
      	end
      	return str
      end

      local function translate(text)
      	local url_request = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="
      		.. target_language
      		.. "&dt=t&q="
      		.. urlencode(text)
      	local res = utils.subprocess({ args = { "curl", "-s", "-S", "-f", url_request } })
      	if res and res.status == 0 then
      		local decoded = json.decode(res.stdout)
      		local translated_text = ""
      		if decoded and decoded[1] then
      			for _, segment in ipairs(decoded[1]) do
      				if segment[1] then
      					translated_text = translated_text .. segment[1]
      				end
      			end
      		end
      		return translated_text:match("^%s*(.-)%s*$")
      	else
      		return "Translation error"
      	end
      end

      local function get_sub()
      	local res = {}
      	res["text"] = mp.get_property("sub-text")
      	if res["text"] == "" or res["text"] == nil then
      		return nil
      	end

      	res["start"] = mp.get_property("sub-start")
      	res["end"] = mp.get_property("sub-end")
      	return res
      end

      local function display_translated_subtitle(translated_text, time_start, time_end)
      	local time_duration = tonumber(time_end - time_start) * 1000
      	translated_text = translated_text:gsub('"', '\\"')

      	local command_string = string.format(
      		[[show-text "''${osd-ass-cc/0}{\\an2\\fs14}''${osd-ass-cc/1}%s\n''${osd-ass-cc/0}{\\fs8}''${osd-ass-cc/1} " %i]],
      		translated_text,
      		time_duration
      	)
      	mp.command(command_string)
      end

      local function check_and_display_subtitles()
      	if not translation_enabled then
      		return
      	end
      	local sub = get_sub()
      	if sub == nil or sub["start"] == last_sub_start then
      		return
      	end
      	last_sub_start = sub["start"]
      	local translated_text = translate(sub["text"])
      	display_translated_subtitle(translated_text, sub["start"], sub["end"])
      end

      local subtitle_check_timer = mp.add_periodic_timer(0.25, check_and_display_subtitles)
      subtitle_check_timer:kill()

      mp.register_event("end-file", function()
      	subtitle_check_timer:kill()
      end)

      local function update_button_icon(icon_name, active, badge, tooltip, command)
      	mp.commandv(
      		"script-message-to",
      		"uosc",
      		"set-button",
      		"toggle_translation",
      		utils.format_json({
      			icon = icon_name,
      			active = active,
      			badge = badge,
      			tooltip = tooltip,
      			command = command,
      		})
      	)
      end

      local function apply_translation_state()
      	if translation_enabled then
      		mp.set_property("sub-visibility", "no")
      		mp.set_property("sub-delay", -0.4)
      		subtitle_check_timer:resume()
      		update_button_icon(
      			"translate",
      			true,
      			false,
      			"Disable Translation",
      			"script-binding sub_translate/toggle_translation"
      		)
      	else
      		mp.set_property("sub-visibility", "yes")
      		mp.set_property("sub-delay", 0)
      		subtitle_check_timer:kill()
      		update_button_icon(
      			"translate",
      			false,
      			false,
      			"Enable Translation",
      			"script-binding sub_translate/toggle_translation"
      		)
      	end
      end

      local function toggle_translation()
      	translation_enabled = not translation_enabled
      	apply_translation_state()
      	if translation_enabled then
      		last_sub_start = nil
      		mp.commandv("frame-back-step")
      		mp.set_property("pause", "no")
      	end
      end

      local function on_file_loaded()
      	last_sub_start = nil
      	apply_translation_state()
      end

      translation_enabled = false
      apply_translation_state()

      mp.register_event("file-loaded", on_file_loaded)
      mp.add_key_binding(nil, "toggle_translation", toggle_translation)
    '';
  };
}
