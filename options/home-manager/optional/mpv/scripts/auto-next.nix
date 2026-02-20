{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/auto-next.lua" = lib.mkIf homes.mpv {
    text = ''
      -- next_on_end.lua

      -- Function to check if the current video is in the specified directory
      local function is_video_in_anime_directory()
      	local path = mp.get_property("path")
      	return path and (path:find("/Videos/Anime/") ~= nil or path:find("/Videos/Movies/") ~= nil)
      end

      -- Function to check if there are at least 3 items in the playlist
      local function has_minimum_playlist_items()
      	return mp.get_property_number("playlist-count") >= 3
      end

      -- Function to check if the video is within the last second
      local function is_within_last_second()
      	local duration = mp.get_property_number("duration")
      	local time_pos = mp.get_property_number("time-pos")
      	return duration and time_pos and (duration - time_pos <= 1)
      end

      -- Function to run the next playlist command
      local function check_and_run_next()
      	if is_video_in_anime_directory() and has_minimum_playlist_items() and is_within_last_second() then
      		mp.commandv("playlist-next")
      	end
      end

      -- Add an event listener for the 'time-pos' property to trigger the check
      mp.observe_property("time-pos", "number", check_and_run_next)
    '';
  };
}
