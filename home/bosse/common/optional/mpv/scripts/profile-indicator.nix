{...}: {
  home.file.".config/mpv/scripts/profile-indicator.lua" = {
    text = ''
      local ov = mp.create_osd_overlay("ass-events")
      ov.data = [[{\an1\p1\alpha&H79\1c&Hffffff&\3a&Hff\pos(0,20)}]] .. [[m0 0 l 100 0 l 0 100]]
      -- Function to show the active profile
      local function show_profile()
      	-- Get video properties
      	local width = mp.get_property_number("width")
      	local height = mp.get_property_number("height")
      	local path = mp.get_property("path")
      	local fps = mp.get_property_number("container-fps")
      	local profile = "None"

      	if width == 3840 and path:find("Videos/Movies/") and fps > 31 then
      		profile = "4k60"
      		ov:update()
      	elseif width == 3840 and path:find("Videos/Movies/") and fps < 31 then
      		profile = "4k30"
      		ov:update()
      	elseif width == 2560 and path:find("Videos/Movies/") and fps > 31 then
      		profile = "2k60"
      		ov:update()
      	elseif width == 2560 and path:find("Videos/Movies/") and fps < 31 then
      		profile = "2k30"
      		ov:update()
      	elseif width == 1920 and path:find("Videos/Movies/") and fps > 31 then
      		profile = "fhd60"
      		ov:update()
      	elseif width == 1920 and path:find("Videos/Movies/") and fps < 31 then
      		profile = "fhd30"
      		ov:update()
      	elseif width == 1280 and path:find("Videos/Movies/") and fps > 31 then
      		profile = "hd30"
      		ov:update()
      	elseif width == 1280 and path:find("Videos/Movies/") and fps < 31 then
      		profile = "hd30"
      		ov:update()
      	elseif width == 640 or width == 704 or width == 720 and path:find("Videos/Movies/") then
      		profile = "sd"
      		ov:update()
      	--
      	elseif width == 3840 and path:find("Videos/Anime/") and fps > 31 then
      		profile = "anime4k60"
      		ov:update()
      	elseif width == 3840 and path:find("Videos/Anime/") and fps < 31 then
      		profile = "anime4k30"
      		ov:update()
      	elseif width == 2560 and path:find("Videos/Anime/") and fps > 31 then
      		profile = "anime2k60"
      		ov:update()
      	elseif width == 2560 and path:find("Videos/Anime/") and fps < 31 then
      		profile = "anime2k30"
      		ov:update()
      	elseif width == 1920 and path:find("Videos/Anime/") and fps > 31 then
      		profile = "animefhd60"
      		ov:update()
      	elseif width == 1920 and path:find("Videos/Anime/") and fps < 31 then
      		profile = "animefhd30"
      		ov:update()
      	elseif width == 1280 and path:find("Videos/Anime/") and fps > 31 then
      		profile = "animehd30"
      		ov:update()
      	elseif width == 1280 and path:find("Videos/Anime/") and fps < 31 then
      		profile = "animehd30"
      		ov:update()
      	elseif height == 480 and path:find("Videos/Anime/") then
      		--		profile = "animesd"
      		ov:update()
      	else
      		ov:remove()
      	end

      	--	mp.osd_message("Applied Profile: " .. profile, 3)
      end

      -- Register the function to run when a video is loaded
      mp.register_event("file-loaded", show_profile)
    '';
  };
}
