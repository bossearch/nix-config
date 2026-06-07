{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/sub-sync.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")

      local function get_active_external_sub_path()
      	local track_list = mp.get_property_native("track-list")
      	for _, track in ipairs(track_list) do
      		if track.type == "sub" and track.selected and track.external then
      			return track["external-filename"]
      		end
      	end
      	return nil
      end

      local function get_internal_sub_track()
      	local track_list = mp.get_property_native("track-list")
      	for _, track in ipairs(track_list) do
      		if track.type == "sub" and not track.external then
      			return track
      		end
      	end
      	return nil
      end

      local function get_temp_dir()
      	return os.getenv("TMPDIR") or os.getenv("TMP") or os.getenv("TEMP") or "/tmp"
      end

      local function extract_internal_sub(subtitle_track)
      	local codec_ext_map = { subrip = "srt", ass = "ass" }
      	local ext = codec_ext_map[subtitle_track["codec"]]

      	if ext == nil then
      		mp.osd_message("Error: Unsupported internal subtitle codec: " .. tostring(subtitle_track["codec"]))
      		return nil
      	end

      	local temp_sub_fp = utils.join_path(get_temp_dir(), "mpv_extracted_sub." .. ext)
      	mp.osd_message("Extracting internal subtitles...")

      	local args = {
      		"ffmpeg",
      		"-hide_banner",
      		"-nostdin",
      		"-y",
      		"-loglevel",
      		"quiet",
      		"-an",
      		"-vn",
      		"-i",
      		mp.get_property("path"),
      		"-map",
      		"0:" .. (subtitle_track["ff-index"] or "s"),
      		"-f",
      		ext,
      		temp_sub_fp,
      	}

      	local result = utils.subprocess({ args = args, cancellable = false })

      	if result.status == 0 then
      		return temp_sub_fp
      	else
      		return nil
      	end
      end

      local function run_ffsubsync(reference_file, target_sub_file)
      	local sub_dir, sub_name = utils.split_path(target_sub_file)
      	local synced_sub_file = utils.join_path(sub_dir, "synced_" .. sub_name)

      	local args = { "ffsubsync", reference_file, "-i", target_sub_file, "-o", synced_sub_file }
      	local result = utils.subprocess({ args = args, cancellable = false })

      	if result.status == 0 then
      		mp.commandv("sub-add", synced_sub_file)
      		mp.osd_message("Subtitles synced and loaded: synced_" .. sub_name)
      	else
      		mp.osd_message("Subtitle sync failed.")
      	end
      end

      local function sync_to_audio()
      	local video_file = mp.get_property("path")
      	local sub_file = get_active_external_sub_path()

      	if not sub_file or sub_file == "" then
      		mp.osd_message("No external subtitle file loaded.")
      		return
      	end

      	mp.osd_message("Syncing subtitles via ffsubsync (Audio)...")
      	run_ffsubsync(video_file, sub_file)
      end

      local function sync_to_internal_sub()
      	local sub_file = get_active_external_sub_path()
      	if not sub_file or sub_file == "" then
      		mp.osd_message("No external subtitle file loaded to sync.")
      		return
      	end

      	local internal_track = get_internal_sub_track()
      	if not internal_track then
      		mp.osd_message("No internal subtitles found in this video.")
      		return
      	end

      	local extracted_ref_sub = extract_internal_sub(internal_track)
      	if not extracted_ref_sub then
      		mp.osd_message("Failed to extract internal subtitle.")
      		return
      	end

      	mp.osd_message("Syncing subtitles via ffsubsync (Internal Sub)...")
      	run_ffsubsync(extracted_ref_sub, sub_file)

      	os.remove(extracted_ref_sub)
      end

      mp.add_key_binding(nil, "sync_to_audio", sync_to_audio)
      mp.add_key_binding(nil, "sync_to_internal_sub", sync_to_internal_sub)
    '';
  };
}
