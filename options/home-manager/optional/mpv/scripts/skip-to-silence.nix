{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/scripts/skip-to-silence.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")

      local MAX_SPEED = 100
      local NORMAL_SPEED = 1
      local ONE_SECOND = 1
      local skip = false
      local startTime = 0

      local opts = { quietness = -30, duration = 0.5 }

      local function setOptions()
      	local options = require("mp.options")
      	options.read_options(opts)
      end

      local function setTime(time)
      	mp.set_property_number("time-pos", time)
      end

      local function getTime()
      	return mp.get_property_native("time-pos")
      end

      local function setSpeed(speed)
      	mp.set_property("speed", speed)
      end

      local function setPause(state)
      	mp.set_property_bool("pause", state)
      end

      local function setMute(state)
      	mp.set_property_bool("mute", state)
      end

      local function initAudioFilter()
      	local af_table = mp.get_property_native("af")
      	af_table[#af_table + 1] = {
      		enabled = false,
      		label = "silencedetect",
      		name = "lavfi",
      		params = { graph = "silencedetect=noise=" .. opts.quietness .. "dB:d=" .. opts.duration },
      	}
      	mp.set_property_native("af", af_table)
      end

      local function setAudioFilter(state)
      	local af_table = mp.get_property_native("af")
      	if #af_table > 0 then
      		for i = #af_table, 1, -1 do
      			if af_table[i].label == "silencedetect" then
      				af_table[i].enabled = state
      				mp.set_property_native("af", af_table)
      				break
      			end
      		end
      	end
      end

      local function dim(state)
      	local d = { width = 0, height = 0 }
      	if state == true then
      		d.width = mp.get_property_native("width") or 0
      		d.height = mp.get_property_native("height") or 0
      	end
      	return d.width .. "x" .. d.height
      end

      local function setVideoFilter(state)
      	local vf_table = mp.get_property_native("vf")
      	if #vf_table > 0 then
      		for i = #vf_table, 1, -1 do
      			if vf_table[i].label == "blackout" then
      				vf_table[i].enabled = state
      				vf_table[i].params = { graph = "nullsink,color=c=black:s=" .. dim(state) }
      				mp.set_property_native("vf", vf_table)
      				break
      			end
      		end
      	end
      end

      local function initVideoFilter()
      	local vf_table = mp.get_property_native("vf")
      	vf_table[#vf_table + 1] = {
      		enabled = false,
      		label = "blackout",
      		name = "lavfi",
      		params = { graph = "" },
      	}
      	mp.set_property_native("vf", vf_table)
      end

      local function stopSkip()
      	setAudioFilter(false)
      	setVideoFilter(false)
      	setMute(false)
      	setSpeed(NORMAL_SPEED)
      end

      local function silenceTrigger(_, value)
      	if value == "{}" or value == nil then
      		return
      	end

      	local skipTime = tonumber(string.match(value, "%d+%.?%d+"))
      	local currTime = getTime()

      	if skipTime == nil or skipTime < currTime + ONE_SECOND then
      		return
      	end

      	stopSkip()
      	setTime(skipTime)
      	skip = false
      	mp.unobserve_property(silenceTrigger)
      end

      local function setAudioTrigger(state)
      	if state == true then
      		mp.observe_property("af-metadata/silencedetect", "string", silenceTrigger)
      	else
      		mp.unobserve_property(silenceTrigger)
      	end
      end

      local function startSkip()
      	startTime = getTime() or 0
      	setAudioFilter(true)
      	setVideoFilter(true)
      	setAudioTrigger(true)
      	setPause(false)
      	setMute(true)
      	setSpeed(MAX_SPEED)
      end

      -- Fix: stopSkip needs to explicitly turn off the audio property listener
      local function wrappedStopSkip()
      	stopSkip()
      	setAudioTrigger(false)
      end

      local function keypress()
      	skip = not skip
      	if skip then
      		startSkip()
      	else
      		wrappedStopSkip()
      		setTime(startTime)
      	end
      end

      setOptions()
      initAudioFilter()
      initVideoFilter()

      mp.add_key_binding("Tab", "skip-key", keypress)
    '';
  };
}
