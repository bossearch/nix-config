{
  home.file.".config/mpv/scripts/pause-image.lua" = {
    text = ''
      -- auto-pause-on-image.lua

      -- List of common image file extensions
      local image_extensions = {
      	"jpg",
      	"jpeg",
      	"png",
      	"gif",
      	"bmp",
      	"tiff",
      	"webp",
      	"svg",
      }

      -- Function to check if the file is an image based on extension
      local function is_image_file(path)
      	local ext = string.match(path, "%.([^%.]+)$")
      	if ext then
      		ext = ext:lower()
      		for _, image_ext in ipairs(image_extensions) do
      			if ext == image_ext then
      				return true
      			end
      		end
      	end
      	return false
      end

      -- Event to auto-pause when a new file is loaded
      mp.register_event("file-loaded", function()
      	local path = mp.get_property("path")
      	if path and is_image_file(path) then
      		mp.set_property("pause", "yes")
      	end
      end)
    '';
  };
}
