{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/uosc-chapter-skip.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")

      local script_name = mp.get_script_name()
      local skip_titles = {}
      local skipped_chapters_this_file = {}
      local cached_chapters = {}
      local last_playlist_pos = nil
      local last_chapter = nil
      local backward_navigation = false
      local format = string.format
      local insert = table.insert

      local function get_config_path()
      	local video_path = mp.get_property("path")
      	if not video_path then
      		return nil
      	end
      	local dir, _ = utils.split_path(video_path)
      	return dir and utils.join_path(dir, "chapter_skip.json") or nil
      end

      local function normalize_title(title)
      	if not title then
      		return ""
      	end
      	return title:lower():gsub("%s+", ""):gsub("0+(%d+)", "%1")
      end

      local function load_local_config()
      	skip_titles = {}
      	skipped_chapters_this_file = {}
      	last_chapter = nil
      	cached_chapters = mp.get_property_native("chapter-list") or {}

      	local current_playlist_pos = mp.get_property_number("playlist-pos")
      	backward_navigation = (last_playlist_pos and current_playlist_pos and current_playlist_pos < last_playlist_pos)
      		or false
      	last_playlist_pos = current_playlist_pos

      	local config_path = get_config_path()
      	if not config_path then
      		return
      	end

      	local f = io.open(config_path, "r")
      	if not f then
      		return
      	end
      	local content = f:read("*all")
      	f:close()

      	local success, data = pcall(utils.parse_json, content)
      	if success and data and data.skip then
      		for i = 1, #data.skip do
      			skip_titles[normalize_title(data.skip[i])] = true
      		end
      	end
      end

      local function save_local_config()
      	local config_path = get_config_path()
      	if not config_path then
      		return
      	end

      	local export_list = {}
      	local added = {}
      	for i = 1, #cached_chapters do
      		local ch = cached_chapters[i]
      		local norm = normalize_title(ch.title)
      		if skip_titles[norm] and not added[norm] then
      			insert(export_list, ch.title)
      			added[norm] = true
      		end
      	end

      	if #export_list > 0 then
      		local data = { skip = export_list }
      		local f = io.open(config_path, "w")
      		if f then
      			f:write(utils.format_json(data))
      			f:close()
      		end
      	else
      		os.remove(config_path)
      	end
      end

      local function create_menu_data()
      	local items = {}
      	for idx = 1, #cached_chapters do
      		local title = cached_chapters[idx].title or format("Chapter %02d", idx)
      		local norm = normalize_title(title)
      		items[idx] = {
      			title = title,
      			icon = skip_titles[norm] and "check_box" or "check_box_outline_blank",
      			value = format("script-message-to %s toggle-chapter %s", script_name, norm),
      		}
      	end
      	return {
      		type = "chapter_skip_settings",
      		title = "Chapters",
      		items = items,
      		keep_open = true,
      	}
      end

      local function update_menu()
      	local json = utils.format_json(create_menu_data())
      	mp.commandv("script-message-to", "uosc", "update-menu", json)
      end

      local function check_chapter_skip(_, current_chapter)
      	if not current_chapter or current_chapter < 0 or #cached_chapters == 0 then
      		return
      	end

      	if last_chapter then
      		if current_chapter < last_chapter then
      			backward_navigation = true
      		elseif current_chapter > last_chapter then
      			backward_navigation = false
      		end
      	end
      	last_chapter = current_chapter

      	if backward_navigation then
      		return
      	end

      	local current_item = cached_chapters[current_chapter + 1]
      	if not current_item then
      		return
      	end

      	local norm = normalize_title(current_item.title)

      	if skip_titles[norm] and not skipped_chapters_this_file[norm] then
      		skipped_chapters_this_file[norm] = true
      		local next_chapter = current_chapter + 1
      		if next_chapter < #cached_chapters then
      			mp.set_property_number("chapter", next_chapter)
      		else
      			mp.command("playlist-next")
      		end
      	end
      end

      mp.register_script_message("toggle-chapter", function(normalized_title)
      	if skip_titles[normalized_title] then
      		skip_titles[normalized_title] = nil
      		skipped_chapters_this_file[normalized_title] = nil
      	else
      		skip_titles[normalized_title] = true
      	end
      	save_local_config()
      	update_menu()
      end)

      mp.register_event("file-loaded", load_local_config)
      mp.observe_property("chapter", "number", check_chapter_skip)

      mp.add_forced_key_binding(nil, "open-menu", function()
      	local json = utils.format_json(create_menu_data())
      	mp.commandv("script-message-to", "uosc", "open-menu", json)
      end)
    '';
  };
}
