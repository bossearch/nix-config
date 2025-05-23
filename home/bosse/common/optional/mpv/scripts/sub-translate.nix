{...}: {
  home.file.".config/mpv/scripts/sub-translate.lua" = {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")
      local json = require("dkjson")
      local translation_enabled = false
      local target_language = "id" -- Set your desired target language here
      local pre_fetch_delay = 2 -- Pre-fetch subtitles in advance (in seconds)

      local function urlencode(str)
        if str then
          str = string.gsub(str, "\n", "\r\n")
          -- Encode all characters that are not alphanumeric, '-' (dash), '.' (dot), '_' (underscore), '~' (tilde), or space
          str = string.gsub(str, "([^%w%-%.%_%~ ])", function(c)
            return string.format("%%%02X", string.byte(c))
          end)
          str = string.gsub(str, " ", "+") -- Encode spaces as '+'
        end
        return str
      end

      local function split_by_punctuation(text)
        local sentences = {}
        for sentence in string.gmatch(text, "[^%.%?!]+[%.%?!]*") do
          table.insert(sentences, sentence)
        end
        return sentences
      end

      local function translate(text, target_language)
        local sentences = split_by_punctuation(text)
        local translated_text = ""

        for _, sentence in ipairs(sentences) do
          local url_request = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="
            .. target_language
            .. "&dt=t&q="
            .. urlencode(sentence)

          local res, err = utils.subprocess({ args = { "curl", "-s", "-S", "-f", url_request } })
          if res and res.status == 0 then
            -- Extract translation from JSON response
            local translated_sentence = json.decode(res.stdout)[1][1][1]
            translated_text = translated_text .. translated_sentence .. " "
          else
            mp.msg.error("Translation error: " .. (err or "Unknown error"))
            return nil
          end
        end

        return translated_text:match("^%s*(.-)%s*$") -- Trim leading/trailing spaces
      end

      function get_sub()
        local res = {}
        res["text"] = mp.get_property("sub-text")
        if res["text"] == "" or res["text"] == nil then
          return nil
        end

        res["start"] = mp.get_property("sub-start")
        res["end"] = mp.get_property("sub-end")
        return res
      end

      local function escape_special_characters(str)
        local escaped_str = string.gsub(str, "([\\{}%[%]%(%)%\\])", "\\%1") -- Escape necessary characters
        escaped_str = string.gsub(escaped_str, "\n", " ") -- Replace LF with a blank space
        return escaped_str
      end

      local function display_translated_subtitle(translated_text, time_start, time_end)
        local time_duration = tonumber(time_end - time_start) * 1000
        if translated_text then
          --		mp.msg.info("translated_text: " .. translated_text) -- Print the translated text to the console
          translated_text = translated_text:gsub('"', '\\"')
          --	local font_size = 30
          local command_string = string.format(
            --"show-text '\''${osd-ass-cc/0}{\\an2}''${osd-ass-cc/1}%s' %i",
            [[show-text "''${osd-ass-cc/0}{\\an2\\bord1\\3c&H000000&\\3a&H4D&}''${osd-ass-cc/1}%s" %i]],
            --"show-text '\''${osd-ass-cc/0}{\\an2\\fs%d}''${osd-ass-cc/1}%s' %d",
            --font_size,
            translated_text,
            time_duration
          )
          mp.command(command_string)
        else
          --		mp.msg.error("Translation error")
          mp.osd_message("Translation error")
        end
      end

      local last_sub_start = nil
      local last_translated_text = nil

      local function check_and_display_subtitles()
        if not translation_enabled then
          return
        end
        local sub = get_sub()
        if sub == nil or sub["start"] == last_sub_start then
          return
        end

        last_sub_start = sub["start"]

        local escaped_sub = escape_special_characters(sub["text"])
        --	mp.msg.info("escaped_sub:" .. escaped_sub)
        local translated_text = translate(escaped_sub, target_language)

        if translated_text then
          --		mp.msg.info("translated_text: " .. translated_text) -- Print the translated text to the console
          last_translated_text = translated_text
          display_translated_subtitle(translated_text, sub["start"], sub["end"])
        else
          mp.msg.error("Translation error")
          mp.osd_message("Translation error")
        end
      end

      --local subtitle_check_timer = mp.add_periodic_timer(0.5, check_and_display_subtitles) -- Check every 0.5 seconds
      local subtitle_check_timer = mp.add_periodic_timer(0.25, check_and_display_subtitles)
      --subtitle_check_timer:kill() -- Start with the timer stopped

      mp.register_event("end-file", function()
        subtitle_check_timer:kill()
      end)

      local first_load_status_file = "/home/bosse/.cache/bosse/first-load-status.txt"
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

      local function toggle_translation()
        local first_load = load_first_load_status()
        local playlist = mp.get_property_number("playlist-count")
        --	translation_enabled = not translation_enabled
        if first_load then
          subtitle_check_timer:kill()
          update_button_icon(
            "translate",
            false,
            false,
            "Enable Translation",
            "script-binding sub_translate/toggle_translation"
          )
        elseif translation_enabled == false and playlist <= 3 and not first_load then
          --		mp.osd_message("Translation enabled")
          mp.set_property("sub-visibility", "no")
          --		mp.set_property("osd-border-style", "opaque-box")
          mp.set_property("sub-delay", -0.4)
          subtitle_check_timer:resume()
          update_button_icon(
            "translate",
            true,
            false,
            "Disable Translation",
            "script-binding sub_translate/toggle_translation"
          )
          translation_enabled = true
          mp.register_event("file-loaded", function()
            mp.osd_message("Translation disabled")
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
            translation_enabled = false
          end)
        elseif translation_enabled == false and playlist > 3 and not first_load then
          --		mp.osd_message("Translation enabled")
          mp.set_property("sub-visibility", "no")
          --		mp.set_property("osd-border-style", "opaque-box")
          mp.set_property("sub-delay", -0.4)
          mp.register_event("playback-restart", function()
            last_sub_start = nil
            last_translated_text = nil
            subtitle_check_timer:resume()
          end)
          mp.commandv("frame-back-step")
          mp.set_property("pause", "no")
          update_button_icon(
            "translate",
            true,
            false,
            "Disable Translation",
            "script-binding sub_translate/toggle_translation"
          )
          translation_enabled = true
        elseif translation_enabled == true and not first_load then
          --		mp.osd_message("Translation disabled")
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
          translation_enabled = false
        end
      end
      toggle_translation()
      mp.add_key_binding("ctrl+t", "toggle_translation", toggle_translation)
    '';
  };
}
