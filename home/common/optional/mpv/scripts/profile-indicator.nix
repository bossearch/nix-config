{
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

      	if height >= 2160 and path:find("Videos/Movies/") then
      		profile = "4k"
      		ov:update()
      	elseif height >= 1440 and height < 2160 and path:find("Videos/Movies/") then
      		profile = "2k"
      		ov:update()
      	elseif height >= 1080 and height < 1440 and path:find("Videos/Movies/") then
      		profile = "fhd"
      		ov:update()
      	elseif height >= 720 and height < 1080 and path:find("Videos/Movies/") then
      		profile = "hd"
      		ov:update()
      	elseif height < 720 and path:find("Videos/Movies/") then
      		profile = "sd"
      		ov:update()
      	--
      	elseif height >= 2160 and path:find("Videos/Anime/") then
      		profile = "anime4k"
      		ov:update()
      	elseif height >= 1440 and height < 2160 and path:find("Videos/Anime/") then
      		profile = "anime2k"
      		ov:update()
      	elseif height >= 1080 and height < 1440 and path:find("Videos/Anime/") then
      		profile = "animefhd"
      		ov:update()
      	elseif height >= 720 and height < 1080 and path:find("Videos/Anime/") then
      		profile = "animehd"
      		ov:update()
      	elseif height < 720 and path:find("Videos/Anime/") then
      		profile = "animesd"
      		ov:update()
      	else
      		ov:remove()
      	end
        mp.osd_message("Applied Profile: " .. profile, 3)
      end

      -- Register the function to run when a video is loaded
      mp.register_event("file-loaded", show_profile)
    '';
  };
}
