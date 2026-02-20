{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/youtube-search.lua" = lib.mkIf homes.mpv {
    text = ''
      --
      -- Based on 'mpv-zenity-open-files'(https://github.com/alifarazz/mpv-zenity-open-files)
      --
      -- Default keybindings:
      --      CTRL+SHIFT+s: search video in youtube.
      --
      table.unpack = table.unpack or unpack
      utils = require("mp.utils")
      limit = 41

      function get_focus_using_xdotool()
      	return utils.subprocess({
      		args = { "xdotool", "getwindowfocus" },
      	})
      end

      function invoke_zenity(args)
      	-- local focus = get_focus_using_xdotool()
      	return utils.subprocess({
      		args = { "zenity", table.unpack(args) },
      		cancellable = false,
      	})
      end

      function search_youtube()
      	local url_select = invoke_zenity({
      		"--entry",
      		"--title=Search Youtube",
      		"--text=Enter Search Text:",
      		"--width=500",
      	})
      	if url_select.status ~= 0 then
      		return
      	end

      	for filename in string.gmatch(url_select.stdout, "[^\n]+") do
      		mp.commandv("loadfile", "ytdl://ytsearch" .. limit .. ":" .. filename, "replace")
      	end
      	mp.command("script-message playlist-view-toggle")
      end

      mp.add_key_binding("CTRL+SHIFT+s", "search_youtube", search_youtube)
    '';
  };
}
