{
  homes,
  lib,
  ...
}: {
  home.file.".config/mpv/script-modules/extended-menu.lua" = lib.mkIf homes.mpv {
    text = ''
      local mp = require("mp")
      local utils = require("mp.utils")
      local assdraw = require("mp.assdraw")

      -- create namespace with default values
      local em = {

      	-- customisable values ------------------------------------------------------

      	lines_to_show = 17, -- NOT including search line
      	pause_on_open = true,
      	resume_on_exit = "only-if-was-paused", -- another possible value is true

      	-- styles (earlyer it was a table, but required many more steps to pass def-s
      	--            here from .conf file)
      	font_size = 21,
      	--font size scales by window
      	scale_by_window = false,
      	-- cursor 'width', useful to change if you have hidpi monitor
      	cursor_x_border = 0.3,
      	line_bottom_margin = 1, -- basically space between lines
      	text_color = {
      		default = "ffffff",
      		accent = "d8a07b",
      		current = "aaaaaa",
      		comment = "636363",
      	},
      	menu_x_padding = 5, -- this padding for now applies only to 'left', not x
      	menu_y_padding = 2, -- but this one applies to both - top & bottom

      	-- values that should be passed from main script ----------------------------

      	search_heading = "Default search heading",
      	-- 'full' is required from main script, 'current_i' is optional
      	-- others are 'private'
      	list = {
      		full = {},
      		filtered = {},
      		current_i = nil,
      		pointer_i = 1,
      		show_from_to = {},
      	},
      	-- field to compare with when searching for 'current value' by 'current_i'
      	index_field = "index",
      	-- fields to use when searching for string match / any other custom searching
      	-- if value has 0 length, then search list item itself
      	filter_by_fields = {},

      	-- 'private' values that are not supposed to be changed from the outside ----

      	is_active = false,
      	-- https://mpv.io/manual/master/#lua-scripting-mp-create-osd-overlay(format)
      	ass = mp.create_osd_overlay("ass-events"),
      	was_paused = false, -- flag that indicates that vid was paused by this script

      	line = "",
      	-- if there was no cursor it wouldn't have been needed, but for now we need
      	-- variable below only to compare it with 'line' and see if we need to filter
      	prev_line = "",
      	cursor = 1,
      	history = {},
      	history_pos = 1,
      	key_bindings = {},
      	insert_mode = false,

      	-- used only in 'update' func to get error text msgs
      	error_codes = {
      		no_match = "Match required",
      		no_submit_provided = "No submit function provided",
      	},
      }

      -- PRIVATE METHODS ------------------------------------------------------------

      -- declare constructor function
      function em:new(o)
      	o = o or {}
      	setmetatable(o, self)
      	self.__index = self

      	-- some options might be customised by user in .conf file and read as strings
      	-- in that case parse those
      	if type(o.filter_by_fields) == "string" then
      		o.filter_by_fields = utils.parse_json(o.filter_by_fields)
      	end

      	if type(o.text_color) == "string" then
      		o.text_color = utils.parse_json(o.text_color)
      	end

      	return o
      end

      -- this func is just a getter of a current list depending on search line
      function em:current()
      	return self.line == "" and self.list.full or self.list.filtered
      end

      -- REVIEW: how to get rid of this wrapper and handle filter func sideeffects
      -- in a more elegant way?
      function em:filter_wrapper()
      	-- handles sideeffect that are needed to be run on filtering list
      	-- cuz the filter func may be redefined in main script and therefore needs
      	-- to be straight forward - only doing filtering and returning the table

      	-- passing current query just in case, so ppl can use it in their custom funcs
      	self.list.filtered = self:filter(self.line)

      	self.prev_line = self.line
      	self.list.pointer_i = 1
      	self:set_from_to(true)
      end

      function em:set_from_to(reset_flag)
      	-- additional variables just for shorter var name
      	local i = self.list.pointer_i
      	local to_show = self.lines_to_show
      	local total = #self:current()

      	if reset_flag or to_show >= total then
      		self.list.show_from_to = { 1, math.min(to_show, total) }
      		return
      	end

      	-- If menu is opened with something already selected we want this 'selected'
      	-- to be displayed close to the middle of the menu. That's why 'show_from_to'
      	-- is not initially set, so we can know - if show_from_to length is 0 - it is
      	-- first call of this func in cur. init
      	if #self.list.show_from_to == 0 then
      		-- set show_from_to so chosen item will be displayed close to middle
      		local half_list = math.ceil(to_show / 2)
      		if i < half_list then
      			self.list.show_from_to = { 1, to_show }
      		elseif total - i < half_list then
      			self.list.show_from_to = { total - to_show + 1, total }
      		else
      			self.list.show_from_to = { i - half_list + 1, i - half_list + to_show }
      		end
      	else
      		table.unpack = table.unpack or unpack -- 5.1 compatibility
      		local first, last = table.unpack(self.list.show_from_to)

      		-- handle cursor moving towards start / end bondary
      		if first ~= 1 and i - first < 2 then
      			self.list.show_from_to = { first - 1, last - 1 }
      		end
      		if last ~= total and last - i < 2 then
      			self.list.show_from_to = { first + 1, last + 1 }
      		end

      		-- handle index jumps from beginning to end and backwards
      		if i > last then
      			self.list.show_from_to = { i - to_show + 1, i }
      		end
      		if i < first then
      			self.list.show_from_to = { 1, to_show }
      		end
      	end
      end

      function em:change_selected_index(num)
      	self.list.pointer_i = self.list.pointer_i + num
      	if self.list.pointer_i < 1 then
      		self.list.pointer_i = #self:current()
      	elseif self.list.pointer_i > #self:current() then
      		self.list.pointer_i = 1
      	end
      	self:set_from_to()
      	self:update()
      end

      -- Render the REPL and console as an ASS OSD
      function em:update(err_code)
      	-- ASS tags documentation here - https://aegi.vmoe.info/docs/3.0/ASS_Tags/

      	-- do not bother if function was called to close the menu..
      	if not self.is_active then
      		em.ass:remove()
      		return
      	end

      	local line_height = self.font_size + self.line_bottom_margin
      	local _, h, aspect = mp.get_osd_size()
      	local wh = self.scale_by_window and 720 or h
      	local ww = wh * aspect

      	-- '+ 1' below is a search string
      	local menu_y_pos = wh - (line_height * (self.lines_to_show + 1) + self.menu_y_padding * 2)

      	-- didn't find better place to handle filtered list update
      	if self.line ~= self.prev_line then
      		self:filter_wrapper()
      	end

      	local function get_background()
      		local a = self:ass_new_wrapper()
      		a:append("{\\1c&H1c1c1c\\1a&H19}") -- background color & opacity
      		a:pos(0, 0)
      		a:draw_start()
      		a:rect_cw(0, menu_y_pos, ww, wh)
      		a:draw_stop()
      		return a.text
      	end

      	local function get_search_header()
      		local a = self:ass_new_wrapper()

      		a:pos(self.menu_x_padding, menu_y_pos + self.menu_y_padding)

      		local search_prefix = table.concat({
      			self:get_font_color("accent"),
      			(#self:current() ~= 0 and self.list.pointer_i or "!"),
      			"/",
      			#self:current(),
      			"\\h\\h",
      			self.search_heading,
      			":\\h",
      		})

      		a:append(search_prefix)
      		-- reset font color after search prefix
      		a:append(self:get_font_color("default"))

      		-- Create the cursor glyph as an ASS drawing. ASS will draw the cursor
      		-- inline with the surrounding text, but it sets the advance to the width
      		-- of the drawing. So the cursor doesn't affect layout too much, make it as
      		-- thin as possible and make it appear to be 1px wide by giving it 0.5px
      		-- horizontal borders.
      		local cheight = self.font_size * 8
      		-- TODO: maybe do it using draw_rect from ass?
      		local cglyph = "{\\r" -- styles reset
      			.. "\\1c&Hffffff&\\3c&Hffffff" -- font color and border color
      			.. "\\xbord"
      			.. self.cursor_x_border
      			.. "\\p4\\pbo24}" -- xborder, scale x8 and baseline offset
      			.. "m 0 0 l 0 "
      			.. cheight -- drawing just a line
      			.. "{\\p0\\r}" -- finish drawing and reset styles
      		local before_cur = self:ass_escape(self.line:sub(1, self.cursor - 1))
      		local after_cur = self:ass_escape(self.line:sub(self.cursor))

      		a:append(table.concat({
      			before_cur,
      			cglyph,
      			self:reset_styles(),
      			self:get_font_color("default"),
      			after_cur,
      			(err_code and "\\h" .. self.error_codes[err_code] or ""),
      		}))

      		return a.text

      		-- NOTE: perhaps this commented code will some day help me in coding cursor
      		-- like in M-x emacs menu:
      		-- Redraw the cursor with the REPL text invisible. This will make the
      		-- cursor appear in front of the text.
      		-- ass:new_event()
      		-- ass:an(1)
      		-- ass:append(style .. '{\\alpha&HFF&}> ' .. before_cur)
      		-- ass:append(cglyph)
      		-- ass:append(style .. '{\\alpha&HFF&}' .. after_cur)
      	end

      	local function get_list()
      		local a = assdraw.ass_new()

      		local function apply_highlighting(y)
      			a:new_event()
      			a:append(self:reset_styles())
      			a:append("{\\1c&Hffffff\\1a&HE6}") -- background color & opacity
      			a:pos(0, 0)
      			a:draw_start()
      			a:rect_cw(0, y, ww, y + self.font_size)
      			a:draw_stop()
      		end

      		-- REVIEW: maybe make another function 'get_line_str' and move there
      		-- everything from this for loop?
      		-- REVIEW: how to use something like table.unpack below?
      		for i = self.list.show_from_to[1], self.list.show_from_to[2] do
      			local value = assert(self:current()[i], "no value with index " .. i)
      			local y_offset = menu_y_pos + self.menu_y_padding + (line_height * (i - self.list.show_from_to[1] + 1))

      			if i == self.list.pointer_i then
      				apply_highlighting(y_offset)
      			end

      			a:new_event()
      			a:append(self:reset_styles())
      			a:pos(self.menu_x_padding, y_offset)
      			a:append(self:get_line(i, value))
      		end

      		return a.text
      	end

      	em.ass.res_x = ww
      	em.ass.res_y = wh
      	em.ass.data = table.concat({
      		get_background(),
      		get_search_header(),
      		get_list(),
      	}, "\n")

      	em.ass:update()
      end

      -- params:
      --  - data : {list: {}, [current_i] : num}
      function em:init(data)
      	self.list.full = data.list or {}
      	self.list.current_i = data.current_i or nil
      	self.list.pointer_i = data.current_i or 1
      	self:set_active(true)
      end

      function em:exit()
      	self:undefine_key_bindings()
      	collectgarbage()
      end

      -- TODO: write some idle func like this
      -- function idle()
      --     if pending_selection then
      --         gallery:set_selection(pending_selection)
      --         pending_selection = nil
      --     end
      --     if ass_changed or geometry_changed then
      --         local ww, wh = mp.get_osd_size()
      --         if geometry_changed then
      --             geometry_changed = false
      --             compute_geometry(ww, wh)
      --         end
      --         if ass_changed then
      --             ass_changed = false
      --             mp.set_osd_ass(ww, wh, ass)
      --         end
      --     end
      -- end
      -- ...
      -- and handle it as follows
      -- init():
      -- mp.register_idle(idle)
      -- idle()
      -- exit():
      -- mp.unregister_idle(idle)
      -- idle()
      -- And in these observers he is setting a flag, that's being checked in func above
      -- mp.observe_property("osd-width", "native", mark_geometry_stale)
      -- mp.observe_property("osd-height", "native", mark_geometry_stale)

      -- PRIVATE METHODS END --------------------------------------------------------

      -- PUBLIC METHODS -------------------------------------------------------------

      function em:filter()
      	-- default filter func, might be redefined in main script
      	local result = {}

      	local function get_full_search_str(v)
      		local str = ""
      		for _, key in ipairs(self.filter_by_fields) do
      			str = str .. (v[key] or "")
      		end
      		return str
      	end

      	for _, v in ipairs(self.list.full) do
      		-- if filter_by_fields has 0 length, then search list item itself
      		if #self.filter_by_fields == 0 then
      			if self:search_method(v) then
      				table.insert(result, v)
      			end
      		else
      			-- NOTE: we might use search_method on fiels separately like this:
      			-- for _,key in ipairs(self.filter_by_fields) do
      			--   if self:search_method(v[key]) then table.insert(result, v) end
      			-- end
      			-- But since im planning to implement fuzzy search in future i need full
      			-- search string here
      			if self:search_method(get_full_search_str(v)) then
      				table.insert(result, v)
      			end
      		end
      	end
      	return result
      end

      -- TODO: implement fuzzy search and maybe match highlights
      function em:search_method(str)
      	-- also might be redefined by main script

      	-- convert to string just to make sure..
      	return tostring(str):lower():find(self.line:lower(), 1, true)
      end

      -- this module requires submit function to be defined in main script
      function em:submit()
      	self:update("no_submit_provided")
      end

      function em:update_list(list)
      	-- for now this func doesn't handle cases when we have 'current_i' to update
      	-- it
      	self.list.full = list
      	if self.line ~= self.prev_line then
      		self:filter_wrapper()
      	end
      end

      -- PUBLIC METHODS END ---------------------------------------------------------

      -- HELPER METHODS -------------------------------------------------------------

      function em:get_line(_, v) -- [i]ndex, [v]alue
      	-- this func might be redefined in main script to get a custom-formatted line
      	-- default implementation of this func supposes that value.content field is a
      	-- String
      	local a = assdraw.ass_new()
      	local style = (self.list.current_i == v[self.index_field]) and "current" or "default"

      	a:append(self:reset_styles())
      	a:append(self:get_font_color(style))
      	-- content as default field, which is holding string
      	-- no point in moving it to main object since content itself is being
      	-- composed in THIS function, that might (and most likely, should) be
      	-- redefined in main script
      	a:append(v.content or "Something is off in `get_line` func")
      	return a.text
      end

      -- REVIEW: for now i don't see normal way of mergin this func with below one
      -- but it's being used only once
      function em:reset_styles()
      	local a = assdraw.ass_new()
      	-- alignment top left, no word wrapping, border 0, shadow 0
      	a:append("{\\an7\\q2\\bord0\\shad0}")
      	a:append("{\\fs" .. self.font_size .. "}")
      	return a.text
      end

      -- function to get rid of some copypaste
      function em:ass_new_wrapper()
      	local a = assdraw.ass_new()
      	a:new_event()
      	a:append(self:reset_styles())
      	return a
      end

      function em:get_font_color(style)
      	return "{\\1c&H" .. self.text_color[style] .. "}"
      end

      -- HELPER METHODS END ---------------------------------------------------------

      --[[
        The below code is a modified implementation of text input from mpv's console.lua:
        https://github.com/mpv-player/mpv/blob/87c9eefb2928252497f6141e847b74ad1158bc61/player/lua/console.lua

        I was too lazy to list all modifications i've done to the script, but if u
        rly need to see those - do diff with the original code
      ]]
      --

      -------------------------------------------------------------------------------
      --                          START ORIGINAL MPV CODE                          --
      -------------------------------------------------------------------------------

      -- Copyright (C) 2019 the mpv developers
      --
      -- Permission to use, copy, modify, and/or distribute this software for any
      -- purpose with or without fee is hereby granted, provided that the above
      -- copyright notice and this permission notice appear in all copies.
      --
      -- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
      -- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
      -- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
      -- SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
      -- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
      -- OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
      -- CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

      function em:detect_platform()
      	local o = {}
      	-- Kind of a dumb way of detecting the platform but whatever
      	if mp.get_property_native("options/vo-mmcss-profile", o) ~= o then
      		return "windows"
      	elseif mp.get_property_native("options/macos-force-dedicated-gpu", o) ~= o then
      		return "macos"
      	elseif os.getenv("WAYLAND_DISPLAY") then
      		return "wayland"
      	end
      	return "x11"
      end

      -- Escape a string for verbatim display on the OSD
      function em:ass_escape(str)
      	-- There is no escape for '\' in ASS (I think?) but '\' is used verbatim if
      	-- it isn't followed by a recognised character, so add a zero-width
      	-- non-breaking space
      	str = str:gsub("\\", "\\\239\187\191")
      	str = str:gsub("{", "\\{")
      	str = str:gsub("}", "\\}")
      	-- Precede newlines with a ZWNBSP to prevent ASS's weird collapsing of
      	-- consecutive newlines
      	str = str:gsub("\n", "\239\187\191\\N")
      	-- Turn leading spaces into hard spaces to prevent ASS from stripping them
      	str = str:gsub("\\N ", "\\N\\h")
      	str = str:gsub("^ ", "\\h")
      	return str
      end

      -- Set the REPL visibility ("enable", Esc)
      function em:set_active(active)
      	if active == self.is_active then
      		return
      	end
      	if active then
      		self.is_active = true
      		self.insert_mode = false
      		mp.enable_messages("terminal-default")
      		self:define_key_bindings()

      		-- set flag 'was_paused' only if vid wasn't paused before EM init
      		if self.pause_on_open and not mp.get_property_bool("pause", false) then
      			mp.set_property_bool("pause", true)
      			self.was_paused = true
      		end

      		self:set_from_to()
      		self:update()
      	else
      		-- no need to call 'update' in this block cuz 'clear' method is calling it
      		self.is_active = false
      		self:undefine_key_bindings()

      		if self.resume_on_exit == true or (self.resume_on_exit == "only-if-was-paused" and self.was_paused) then
      			mp.set_property_bool("pause", false)
      		end

      		self:clear()
      		collectgarbage()
      	end
      end

      -- Naive helper function to find the next UTF-8 character in 'str' after 'pos'
      -- by skipping continuation bytes. Assumes 'str' contains valid UTF-8.
      function em:next_utf8(str, pos)
      	if pos > str:len() then
      		return pos
      	end
      	repeat
      		pos = pos + 1
      	until pos > str:len() or str:byte(pos) < 0x80 or str:byte(pos) > 0xbf
      	return pos
      end

      -- As above, but finds the previous UTF-8 charcter in 'str' before 'pos'
      function em:prev_utf8(str, pos)
      	if pos <= 1 then
      		return pos
      	end
      	repeat
      		pos = pos - 1
      	until pos <= 1 or str:byte(pos) < 0x80 or str:byte(pos) > 0xbf
      	return pos
      end

      -- Insert a character at the current cursor position (any_unicode)
      function em:handle_char_input(c)
      	if self.insert_mode then
      		self.line = self.line:sub(1, self.cursor - 1) .. c .. self.line:sub(self:next_utf8(self.line, self.cursor))
      	else
      		self.line = self.line:sub(1, self.cursor - 1) .. c .. self.line:sub(self.cursor)
      	end
      	self.cursor = self.cursor + #c
      	self:update()
      end

      -- Remove the character behind the cursor (Backspace)
      function em:handle_backspace()
      	if self.cursor <= 1 then
      		return
      	end
      	local prev = self:prev_utf8(self.line, self.cursor)
      	self.line = self.line:sub(1, prev - 1) .. self.line:sub(self.cursor)
      	self.cursor = prev
      	self:update()
      end

      -- Remove the character in front of the cursor (Del)
      function em:handle_del()
      	if self.cursor > self.line:len() then
      		return
      	end
      	self.line = self.line:sub(1, self.cursor - 1) .. self.line:sub(self:next_utf8(self.line, self.cursor))
      	self:update()
      end

      -- Toggle insert mode (Ins)
      function em:handle_ins()
      	self.insert_mode = not self.insert_mode
      end

      -- Move the cursor to the next character (Right)
      function em:next_char()
      	self.cursor = self:next_utf8(self.line, self.cursor)
      	self:update()
      end

      -- Move the cursor to the previous character (Left)
      function em:prev_char()
      	self.cursor = self:prev_utf8(self.line, self.cursor)
      	self:update()
      end

      -- Clear the current line (Ctrl+C)
      function em:clear()
      	self.line = ""
      	self.prev_line = ""

      	self.list.current_i = nil
      	self.list.pointer_i = 1
      	self.list.filtered = {}
      	self.list.show_from_to = {}

      	self.was_paused = false

      	self.cursor = 1
      	self.insert_mode = false
      	self.history_pos = #self.history + 1

      	self:update()
      end

      -- Run the current command and clear the line (Enter)
      function em:handle_enter()
      	if #self:current() == 0 then
      		self:update("no_match")
      		return
      	end

      	if self.history[#self.history] ~= self.line then
      		self.history[#self.history + 1] = self.line
      	end

      	self:submit(self:current()[self.list.pointer_i])
      	self:set_active(false)
      end

      -- Go to the specified position in the command history
      function em:go_history(new_pos)
      	local old_pos = self.history_pos
      	self.history_pos = new_pos

      	-- Restrict the position to a legal value
      	if self.history_pos > #self.history + 1 then
      		self.history_pos = #self.history + 1
      	elseif self.history_pos < 1 then
      		self.history_pos = 1
      	end

      	-- Do nothing if the history position didn't actually change
      	if self.history_pos == old_pos then
      		return
      	end

      	-- If the user was editing a non-history line, save it as the last history
      	-- entry. This makes it much less frustrating to accidentally hit Up/Down
      	-- while editing a line.
      	if old_pos == #self.history + 1 and self.line ~= "" and self.history[#self.history] ~= self.line then
      		self.history[#self.history + 1] = self.line
      	end

      	-- Now show the history line (or a blank line for #history + 1)
      	if self.history_pos <= #self.history then
      		self.line = self.history[self.history_pos]
      	else
      		self.line = ""
      	end
      	self.cursor = self.line:len() + 1
      	self.insert_mode = false
      	self:update()
      end

      -- Go to the specified relative position in the command history (Up, Down)
      function em:move_history(amount)
      	self:go_history(self.history_pos + amount)
      end

      -- Go to the first command in the command history (PgUp)
      function em:handle_pgup()
      	self:go_history(1)
      end

      -- Stop browsing history and start editing a blank line (PgDown)
      function em:handle_pgdown()
      	self:go_history(#self.history + 1)
      end

      -- Move to the start of the current word, or if already at the start, the start
      -- of the previous word. (Ctrl+Left)
      function em:prev_word()
      	-- This is basically the same as next_word() but backwards, so reverse the
      	-- string in order to do a "backwards" find. This wouldn't be as annoying
      	-- to do if Lua didn't insist on 1-based indexing.
      	self.cursor = self.line:len()
      		- select(2, self.line:reverse():find("%s*[^%s]*", self.line:len() - self.cursor + 2))
      		+ 1
      	self:update()
      end

      -- Move to the end of the current word, or if already at the end, the end of
      -- the next word. (Ctrl+Right)
      function em:next_word()
      	self.cursor = select(2, self.line:find("%s*[^%s]*", self.cursor)) + 1
      	self:update()
      end

      -- Move the cursor to the beginning of the line (HOME)
      function em:go_home()
      	self.cursor = 1
      	self:update()
      end

      -- Move the cursor to the end of the line (END)
      function em:go_end()
      	self.cursor = self.line:len() + 1
      	self:update()
      end

      -- Delete from the cursor to the beginning of the word (Ctrl+Backspace)
      function em:del_word()
      	local before_cur = self.line:sub(1, self.cursor - 1)
      	local after_cur = self.line:sub(self.cursor)

      	before_cur = before_cur:gsub("[^%s]+%s*$", "", 1)
      	self.line = before_cur .. after_cur
      	self.cursor = before_cur:len() + 1
      	self:update()
      end

      -- Delete from the cursor to the end of the word (Ctrl+Del)
      function em:del_next_word()
      	if self.cursor > self.line:len() then
      		return
      	end

      	local before_cur = self.line:sub(1, self.cursor - 1)
      	local after_cur = self.line:sub(self.cursor)

      	after_cur = after_cur:gsub("^%s*[^%s]+", "", 1)
      	self.line = before_cur .. after_cur
      	self:update()
      end

      -- Delete from the cursor to the end of the line (Ctrl+K)
      function em:del_to_eol()
      	self.line = self.line:sub(1, self.cursor - 1)
      	self:update()
      end

      -- Delete from the cursor back to the start of the line (Ctrl+U)
      function em:del_to_start()
      	self.line = self.line:sub(self.cursor)
      	self.cursor = 1
      	self:update()
      end

      -- Returns a string of UTF-8 text from the clipboard (or the primary selection)
      function em:get_clipboard(clip)
      	-- Pick a better default font for Windows and macOS
      	local platform = self:detect_platform()

      	if platform == "x11" then
      		local res = utils.subprocess({
      			args = { "xclip", "-selection", clip and "clipboard" or "primary", "-out" },
      			playback_only = false,
      		})
      		if not res.error then
      			return res.stdout
      		end
      	elseif platform == "wayland" then
      		local res = utils.subprocess({
      			args = { "wl-paste", clip and "-n" or "-np" },
      			playback_only = false,
      		})
      		if not res.error then
      			return res.stdout
      		end
      	elseif platform == "windows" then
      		local res = utils.subprocess({
      			args = {
      				"powershell",
      				"-NoProfile",
      				"-Command",
      				[[& {
                      Trap {
                          Write-Error -ErrorRecord $_
                          Exit 1
                      }

                      $clip = ""
                      if (Get-Command "Get-Clipboard" -errorAction SilentlyContinue) {
                          $clip = Get-Clipboard -Raw -Format Text -TextFormatType UnicodeText
                      } else {
                          Add-Type -AssemblyName PresentationCore
                          $clip = [Windows.Clipboard]::GetText()
                      }

                      $clip = $clip -Replace "`r",""
                      $u8clip = [System.Text.Encoding]::UTF8.GetBytes($clip)
                      [Console]::OpenStandardOutput().Write($u8clip, 0, $u8clip.Length)
                  }]],
      			},
      			playback_only = false,
      		})
      		if not res.error then
      			return res.stdout
      		end
      	elseif platform == "macos" then
      		local res = utils.subprocess({
      			args = { "pbpaste" },
      			playback_only = false,
      		})
      		if not res.error then
      			return res.stdout
      		end
      	end
      	return ""
      end

      -- Paste text from the window-system's clipboard. 'clip' determines whether the
      -- clipboard or the primary selection buffer is used (on X11 and Wayland only.)
      function em:paste(clip)
      	local text = self:get_clipboard(clip)
      	local before_cur = self.line:sub(1, self.cursor - 1)
      	local after_cur = self.line:sub(self.cursor)
      	self.line = before_cur .. text .. after_cur
      	self.cursor = self.cursor + text:len()
      	self:update()
      end

      -- List of input bindings. This is a weird mashup between common GUI text-input
      -- bindings and readline bindings.
      function em:get_bindings()
      	local bindings = {
      		{
      			"ctrl+[",
      			function()
      				self:set_active(false)
      			end,
      		},
      		{
      			"ctrl+g",
      			function()
      				self:set_active(false)
      			end,
      		},
      		{
      			"esc",
      			function()
      				self:set_active(false)
      			end,
      		},
      		{
      			"enter",
      			function()
      				self:handle_enter()
      			end,
      		},
      		{
      			"kp_enter",
      			function()
      				self:handle_enter()
      			end,
      		},
      		{
      			"ctrl+m",
      			function()
      				self:handle_enter()
      			end,
      		},
      		{
      			"bs",
      			function()
      				self:handle_backspace()
      			end,
      		},
      		{
      			"shift+bs",
      			function()
      				self:handle_backspace()
      			end,
      		},
      		{
      			"ctrl+h",
      			function()
      				self:handle_backspace()
      			end,
      		},
      		{
      			"del",
      			function()
      				self:handle_del()
      			end,
      		},
      		{
      			"shift+del",
      			function()
      				self:handle_del()
      			end,
      		},
      		{
      			"ins",
      			function()
      				self:handle_ins()
      			end,
      		},
      		{
      			"shift+ins",
      			function()
      				self:paste(false)
      			end,
      		},
      		{
      			"mbtn_mid",
      			function()
      				self:paste(false)
      			end,
      		},
      		{
      			"left",
      			function()
      				self:prev_char()
      			end,
      		},
      		{
      			"ctrl+b",
      			function()
      				self:prev_char()
      			end,
      		},
      		{
      			"right",
      			function()
      				self:next_char()
      			end,
      		},
      		{
      			"ctrl+f",
      			function()
      				self:next_char()
      			end,
      		},
      		{
      			"ctrl+k",
      			function()
      				self:change_selected_index(-1)
      			end,
      		},
      		{
      			"ctrl+p",
      			function()
      				self:change_selected_index(-1)
      			end,
      		},
      		{
      			"ctrl+j",
      			function()
      				self:change_selected_index(1)
      			end,
      		},
      		{
      			"ctrl+n",
      			function()
      				self:change_selected_index(1)
      			end,
      		},
      		{
      			"up",
      			function()
      				self:move_history(-1)
      			end,
      		},
      		{
      			"alt+p",
      			function()
      				self:move_history(-1)
      			end,
      		},
      		{
      			"wheel_up",
      			function()
      				self:move_history(-1)
      			end,
      		},
      		{
      			"down",
      			function()
      				self:move_history(1)
      			end,
      		},
      		{
      			"alt+n",
      			function()
      				self:move_history(1)
      			end,
      		},
      		{
      			"wheel_down",
      			function()
      				self:move_history(1)
      			end,
      		},
      		{ "wheel_left", function() end },
      		{ "wheel_right", function() end },
      		{
      			"ctrl+left",
      			function()
      				self:prev_word()
      			end,
      		},
      		{
      			"alt+b",
      			function()
      				self:prev_word()
      			end,
      		},
      		{
      			"ctrl+right",
      			function()
      				self:next_word()
      			end,
      		},
      		{
      			"alt+f",
      			function()
      				self:next_word()
      			end,
      		},
      		{
      			"ctrl+a",
      			function()
      				self:go_home()
      			end,
      		},
      		{
      			"home",
      			function()
      				self:go_home()
      			end,
      		},
      		{
      			"ctrl+e",
      			function()
      				self:go_end()
      			end,
      		},
      		{
      			"end",
      			function()
      				self:go_end()
      			end,
      		},
      		{
      			"pgup",
      			function()
      				self:handle_pgup()
      			end,
      		},
      		{
      			"pgdwn",
      			function()
      				self:handle_pgdown()
      			end,
      		},
      		{
      			"ctrl+c",
      			function()
      				self:clear()
      			end,
      		},
      		{
      			"ctrl+d",
      			function()
      				self:handle_del()
      			end,
      		},
      		{
      			"ctrl+u",
      			function()
      				self:del_to_start()
      			end,
      		},
      		{
      			"ctrl+v",
      			function()
      				self:paste(true)
      			end,
      		},
      		{
      			"meta+v",
      			function()
      				self:paste(true)
      			end,
      		},
      		{
      			"ctrl+bs",
      			function()
      				self:del_word()
      			end,
      		},
      		{
      			"ctrl+w",
      			function()
      				self:del_word()
      			end,
      		},
      		{
      			"ctrl+del",
      			function()
      				self:del_next_word()
      			end,
      		},
      		{
      			"alt+d",
      			function()
      				self:del_next_word()
      			end,
      		},
      		{
      			"kp_dec",
      			function()
      				self:handle_char_input(".")
      			end,
      		},
      	}

      	for i = 0, 9 do
      		bindings[#bindings + 1] = {
      			"kp" .. i,
      			function()
      				self:handle_char_input("" .. i)
      			end,
      		}
      	end

      	return bindings
      end

      function em:text_input(info)
      	if info.key_text and (info.event == "press" or info.event == "down" or info.event == "repeat") then
      		self:handle_char_input(info.key_text)
      	end
      end

      function em:define_key_bindings()
      	if #self.key_bindings > 0 then
      		return
      	end
      	for _, bind in ipairs(self:get_bindings()) do
      		-- Generate arbitrary name for removing the bindings later.
      		local name = "search_" .. (#self.key_bindings + 1)
      		self.key_bindings[#self.key_bindings + 1] = name
      		mp.add_forced_key_binding(bind[1], name, bind[2], { repeatable = true })
      	end
      	mp.add_forced_key_binding("any_unicode", "search_input", function(...)
      		self:text_input(...)
      	end, { repeatable = true, complex = true })
      	self.key_bindings[#self.key_bindings + 1] = "search_input"
      end

      function em:undefine_key_bindings()
      	for _, name in ipairs(self.key_bindings) do
      		mp.remove_key_binding(name)
      	end
      	self.key_bindings = {}
      end

      -------------------------------------------------------------------------------
      --                           END ORIGINAL MPV CODE                           --
      -------------------------------------------------------------------------------

      return em
    '';
  };
  home.file.".config/mpv/script-modules/gallery.lua" = lib.mkIf homes.mpv {
    text = ''
      local utils = require("mp.utils")
      local msg = require("mp.msg")
      local assdraw = require("mp.assdraw")

      local gallery_mt = {}
      gallery_mt.__index = gallery_mt

      function gallery_new()
      	local gallery = setmetatable({
      		-- public, can be modified by user
      		items = {},
      		item_to_overlay_path = function(index, item)
      			return ""
      		end,
      		item_to_thumbnail_params = function(index, item)
      			return "", 0
      		end,
      		item_to_text = function(index, item)
      			return "", true
      		end,
      		item_to_border = function(index, item)
      			return 0, ""
      		end,
      		ass_show = function(ass) end,
      		config = {
      			background_color = "333333",
      			background_opacity = "33",
      			background_roundness = 5,
      			scrollbar = true,
      			scrollbar_left_side = false,
      			scrollbar_min_size = 10,
      			overlay_range = 0,
      			max_thumbnails = 64,
      			show_placeholders = true,
      			always_show_placeholders = false,
      			placeholder_color = "222222",
      			text_size = 28,
      			align_text = true,
      			accurate = false,
      			generate_thumbnails_with_mpv = false,
      		},

      		-- private, can be read but should not be modified
      		active = false,
      		geometry = {
      			ok = false,
      			position = { 0, 0 },
      			size = { 0, 0 },
      			min_spacing = { 0, 0 },
      			thumbnail_size = { 0, 0 },
      			rows = 0,
      			columns = 0,
      			effective_spacing = { 0, 0 },
      		},
      		view = { -- 1-based indices into the "playlist" array
      			first = 0, -- must be equal to N*columns
      			last = 0, -- must be > first and <= first + rows*columns
      		},
      		overlays = {
      			active = {}, -- array of <=64 strings indicating the file associated to the current overlay (false if nothing)
      			missing = {}, -- associative array of thumbnail path to view index it should be shown at
      		},
      		selection = nil,
      		ass = {
      			background = "",
      			selection = "",
      			scrollbar = "",
      			placeholders = "",
      		},
      		generators = {}, -- list of generator scripts
      	}, gallery_mt)

      	for i = 1, gallery.config.max_thumbnails do
      		gallery.overlays.active[i] = false
      	end
      	return gallery
      end

      function gallery_mt.show_overlay(gallery, index_1, thumb_path)
      	local g = gallery.geometry
      	gallery.overlays.active[index_1] = thumb_path
      	local index_0 = index_1 - 1
      	local x, y = gallery:view_index_position(index_0)
      	mp.commandv(
      		"overlay-add",
      		tostring(index_0 + gallery.config.overlay_range),
      		tostring(math.floor(x + 0.5)),
      		tostring(math.floor(y + 0.5)),
      		thumb_path,
      		"0",
      		"bgra",
      		tostring(g.thumbnail_size[1]),
      		tostring(g.thumbnail_size[2]),
      		tostring(4 * g.thumbnail_size[1])
      	)
      	mp.osd_message(" ", 0.01)
      end

      function gallery_mt.remove_overlays(gallery)
      	for view_index, _ in pairs(gallery.overlays.active) do
      		mp.commandv("overlay-remove", gallery.config.overlay_range + view_index - 1)
      		gallery.overlays.active[view_index] = false
      	end
      	gallery.overlays.missing = {}
      end

      local function file_exists(path)
      	local info = utils.file_info(path)
      	return info ~= nil and info.is_file
      end

      function gallery_mt.refresh_overlays(gallery, force)
      	local todo = {}
      	local o = gallery.overlays
      	local g = gallery.geometry
      	o.missing = {}
      	for view_index = 1, g.rows * g.columns do
      		local index = gallery.view.first + view_index - 1
      		local active = o.active[view_index]
      		if index > 0 and index <= #gallery.items then
      			local thumb_path = gallery.item_to_overlay_path(index, gallery.items[index])
      			if not force and active == thumb_path then
      				-- nothing to do
      			elseif file_exists(thumb_path) then
      				gallery:show_overlay(view_index, thumb_path)
      			else
      				-- need to generate that thumbnail
      				o.active[view_index] = false
      				mp.commandv("overlay-remove", gallery.config.overlay_range + view_index - 1)
      				o.missing[thumb_path] = view_index
      				todo[#todo + 1] = { index = index, output = thumb_path }
      			end
      		else
      			-- might happen if we're close to the end of gallery.items
      			if active ~= false then
      				o.active[view_index] = false
      				mp.commandv("overlay-remove", gallery.config.overlay_range + view_index - 1)
      			end
      		end
      	end
      	if #gallery.generators >= 1 then
      		-- reverse iterate so that the first thumbnail is at the top of the stack
      		for i = #todo, 1, -1 do
      			local generator = gallery.generators[i % #gallery.generators + 1]
      			local t = todo[i]
      			local input_path, time = gallery.item_to_thumbnail_params(t.index, gallery.items[t.index])
      			mp.commandv(
      				"script-message-to",
      				generator,
      				"push-thumbnail-front",
      				mp.get_script_name(),
      				input_path,
      				tostring(g.thumbnail_size[1]),
      				tostring(g.thumbnail_size[2]),
      				time,
      				t.output,
      				gallery.config.accurate and "true" or "false",
      				gallery.config.generate_thumbnails_with_mpv and "true" or "false"
      			)
      		end
      	end
      end

      function gallery_mt.index_at(gallery, mx, my)
      	local g = gallery.geometry
      	if mx < g.position[1] or my < g.position[2] then
      		return nil
      	end
      	mx = mx - g.position[1]
      	my = my - g.position[2]
      	if mx > g.size[1] or my > g.size[2] then
      		return nil
      	end
      	mx = mx - g.effective_spacing[1]
      	my = my - g.effective_spacing[2]
      	local on_column = (mx % (g.thumbnail_size[1] + g.effective_spacing[1])) < g.thumbnail_size[1]
      	local on_row = (my % (g.thumbnail_size[2] + g.effective_spacing[2])) < g.thumbnail_size[2]
      	if on_column and on_row then
      		local column = math.floor(mx / (g.thumbnail_size[1] + g.effective_spacing[1]))
      		local row = math.floor(my / (g.thumbnail_size[2] + g.effective_spacing[2]))
      		local index = gallery.view.first + row * g.columns + column
      		if index > 0 and index <= gallery.view.last then
      			return index
      		end
      	end
      	return nil
      end

      function gallery_mt.compute_internal_geometry(gallery)
      	local g = gallery.geometry
      	g.rows = math.floor((g.size[2] - g.min_spacing[2]) / (g.thumbnail_size[2] + g.min_spacing[2]))
      	g.columns = math.floor((g.size[1] - g.min_spacing[1]) / (g.thumbnail_size[1] + g.min_spacing[1]))
      	if g.rows <= 0 or g.columns <= 0 then
      		g.rows = 0
      		g.columns = 0
      		g.effective_spacing[1] = g.size[1]
      		g.effective_spacing[2] = g.size[2]
      		return
      	end
      	if g.rows * g.columns > gallery.config.max_thumbnails then
      		local r = math.sqrt(g.rows * g.columns / gallery.config.max_thumbnails)
      		g.rows = math.floor(g.rows / r)
      		g.columns = math.floor(g.columns / r)
      	end
      	g.effective_spacing[1] = (g.size[1] - g.columns * g.thumbnail_size[1]) / (g.columns + 1)
      	g.effective_spacing[2] = (g.size[2] - g.rows * g.thumbnail_size[2]) / (g.rows + 1)
      end

      -- makes sure that view.first and view.last are valid with regards to the playlist
      -- and that selection is within the view
      -- to be called after the playlist, view or selection was modified somehow
      function gallery_mt.ensure_view_valid(gallery)
      	local g = gallery.geometry
      	if #gallery.items == 0 or g.rows == 0 or g.columns == 0 then
      		gallery.view.first = 0
      		gallery.view.last = 0
      		return
      	end
      	local v = gallery.view
      	local selection_row = math.floor((gallery.selection - 1) / g.columns)
      	local max_thumbs = g.rows * g.columns
      	local changed = false

      	if v.last >= #gallery.items then
      		v.last = #gallery.items
      		if g.rows == 1 then
      			v.first = math.max(1, v.last - g.columns + 1)
      		else
      			local last_row = math.floor((v.last - 1) / g.columns)
      			local first_row = math.max(0, last_row - g.rows + 1)
      			v.first = 1 + first_row * g.columns
      		end
      		changed = true
      	elseif v.first == 0 or v.last == 0 or v.last - v.first + 1 ~= max_thumbs then
      		-- special case: the number of possible thumbnails was changed
      		-- just recreate the view such that the selection is in the middle row
      		local max_row = (#gallery.items - 1) / g.columns + 1
      		local row_first = selection_row - math.floor((g.rows - 1) / 2)
      		local row_last = selection_row + math.floor((g.rows - 1) / 2) + g.rows % 2
      		if row_first < 0 then
      			row_first = 0
      		elseif row_last > max_row then
      			row_first = max_row - g.rows + 1
      		end
      		v.first = 1 + row_first * g.columns
      		v.last = math.min(#gallery.items, v.first - 1 + max_thumbs)
      		return true
      	end

      	if gallery.selection < v.first then
      		-- the selection is now on the first line
      		v.first = (g.rows == 1) and gallery.selection or selection_row * g.columns + 1
      		v.last = math.min(#gallery.items, v.first + max_thumbs - 1)
      		changed = true
      	elseif gallery.selection > v.last then
      		v.last = (g.rows == 1) and gallery.selection or (selection_row + 1) * g.columns
      		v.first = math.max(1, v.last - max_thumbs + 1)
      		v.last = math.min(#gallery.items, v.last)
      		changed = true
      	end
      	return changed
      end

      -- ass related stuff
      function gallery_mt.refresh_background(gallery)
      	local g = gallery.geometry
      	local a = assdraw.ass_new()
      	a:new_event()
      	a:append("{\\an7}")
      	a:append("{\\bord0}")
      	a:append("{\\shad0}")
      	a:append("{\\1c&" .. gallery.config.background_color .. "}")
      	a:append("{\\1a&" .. gallery.config.background_opacity .. "}")
      	a:pos(0, 0)
      	a:draw_start()
      	a:round_rect_cw(
      		g.position[1],
      		g.position[2],
      		g.position[1] + g.size[1],
      		g.position[2] + g.size[2],
      		gallery.config.background_roundness
      	)
      	a:draw_stop()
      	gallery.ass.background = a.text
      end

      function gallery_mt.refresh_placeholders(gallery)
      	if not gallery.config.show_placeholders then
      		return
      	end
      	if gallery.view.first == 0 then
      		gallery.ass.placeholders = ""
      		return
      	end
      	local g = gallery.geometry
      	local a = assdraw.ass_new()
      	a:new_event()
      	a:append("{\\an7}")
      	a:append("{\\bord0}")
      	a:append("{\\shad0}")
      	a:append("{\\1c&" .. gallery.config.placeholder_color .. "}")
      	a:pos(0, 0)
      	a:draw_start()
      	for i = 0, gallery.view.last - gallery.view.first do
      		if gallery.config.always_show_placeholders or not gallery.overlays.active[i + 1] then
      			local x, y = gallery:view_index_position(i)
      			a:rect_cw(x, y, x + g.thumbnail_size[1], y + g.thumbnail_size[2])
      		end
      	end
      	a:draw_stop()
      	gallery.ass.placeholders = a.text
      end

      function gallery_mt.refresh_scrollbar(gallery)
      	if not gallery.config.scrollbar then
      		return
      	end
      	gallery.ass.scrollbar = ""
      	if gallery.view.first == 0 then
      		return
      	end
      	local g = gallery.geometry
      	local before = (gallery.view.first - 1) / #gallery.items
      	local after = (#gallery.items - gallery.view.last) / #gallery.items
      	-- don't show the scrollbar if everything is visible
      	if before + after == 0 then
      		return
      	end
      	local p = gallery.config.scrollbar_min_size / 100
      	if before + after > 1 - p then
      		if before == 0 then
      			after = (1 - p)
      		elseif after == 0 then
      			before = (1 - p)
      		else
      			before, after =
      				before / after * (1 - p) / (1 + before / after), after / before * (1 - p) / (1 + after / before)
      		end
      	end
      	local dist_from_edge = g.size[2] * 0.015
      	local y1 = g.position[2] + dist_from_edge + before * (g.size[2] - 2 * dist_from_edge)
      	local y2 = g.position[2] + g.size[2] - (dist_from_edge + after * (g.size[2] - 2 * dist_from_edge))
      	local x1, x2
      	if gallery.config.scrollbar_left_side then
      		x1 = g.position[1] + g.effective_spacing[1] / 2 - 2
      	else
      		x1 = g.position[1] + g.size[1] - g.effective_spacing[1] / 2 - 2
      	end
      	x2 = x1 + 4
      	local scrollbar = assdraw.ass_new()
      	scrollbar:new_event()
      	scrollbar:append("{\\an7}")
      	scrollbar:append("{\\bord0}")
      	scrollbar:append("{\\shad0}")
      	scrollbar:append("{\\1c&AAAAAA&}")
      	scrollbar:pos(0, 0)
      	scrollbar:draw_start()
      	scrollbar:rect_cw(x1, y1, x2, y2)
      	scrollbar:draw_stop()
      	gallery.ass.scrollbar = scrollbar.text
      end

      function gallery_mt.refresh_selection(gallery)
      	local v = gallery.view
      	if v.first == 0 then
      		gallery.ass.selection = ""
      		return
      	end
      	local selection_ass = assdraw.ass_new()
      	local g = gallery.geometry
      	local draw_frame = function(index, size, color)
      		local x, y = gallery:view_index_position(index - v.first)
      		selection_ass:new_event()
      		selection_ass:append("{\\an7}")
      		selection_ass:append("{\\bord" .. size .. "}")
      		selection_ass:append("{\\3c&" .. color .. "&}")
      		selection_ass:append("{\\1a&FF&}")
      		selection_ass:pos(0, 0)
      		selection_ass:draw_start()
      		selection_ass:rect_cw(x, y, x + g.thumbnail_size[1], y + g.thumbnail_size[2])
      		selection_ass:draw_stop()
      	end
      	for i = v.first, v.last do
      		local size, color = gallery.item_to_border(i, gallery.items[i])
      		if size > 0 then
      			draw_frame(i, size, color)
      		end
      	end

      	for index = v.first, v.last do
      		local text = gallery.item_to_text(index, gallery.items[index])
      		if text ~= "" then
      			selection_ass:new_event()
      			local an = 5
      			local x, y = gallery:view_index_position(index - v.first)
      			x = x + g.thumbnail_size[1] / 2
      			y = y + g.thumbnail_size[2] + gallery.config.text_size * 0.75
      			if gallery.config.align_text then
      				local col = (index - v.first) % g.columns
      				if g.columns > 1 then
      					if col == 0 then
      						x = x - g.thumbnail_size[1] / 2
      						an = 4
      					elseif col == g.columns - 1 then
      						x = x + g.thumbnail_size[1] / 2
      						an = 6
      					end
      				end
      			end
      			selection_ass:an(an)
      			selection_ass:pos(x, y)
      			selection_ass:append(string.format("{\\fs%d}", gallery.config.text_size))
      			selection_ass:append("{\\bord0}")
      			selection_ass:append(text)
      		end
      	end
      	gallery.ass.selection = selection_ass.text
      end

      function gallery_mt.ass_refresh(gallery, selection, scrollbar, placeholders, background)
      	if not gallery.active then
      		return
      	end
      	if selection then
      		gallery:refresh_selection()
      	end
      	if scrollbar then
      		gallery:refresh_scrollbar()
      	end
      	if placeholders then
      		gallery:refresh_placeholders()
      	end
      	if background then
      		gallery:refresh_background()
      	end
      	gallery.ass_show(table.concat({
      		gallery.ass.background,
      		gallery.ass.placeholders,
      		gallery.ass.selection,
      		gallery.ass.scrollbar,
      	}, "\n"))
      end

      function gallery_mt.set_selection(gallery, selection)
      	if not selection or selection ~= selection then
      		return
      	end
      	local new_selection = math.max(1, math.min(selection, #gallery.items))
      	if gallery.selection == new_selection then
      		return
      	end
      	gallery.selection = new_selection
      	if gallery.active then
      		if gallery:ensure_view_valid() then
      			gallery:refresh_overlays(false)
      			gallery:ass_refresh(true, true, true, false)
      		else
      			gallery:ass_refresh(true, false, false, false)
      		end
      	end
      end

      function gallery_mt.set_geometry(gallery, x, y, w, h, sw, sh, tw, th)
      	if w <= 0 or h <= 0 or tw <= 0 or th <= 0 then
      		msg.warn("Invalid coordinates")
      		return
      	end
      	gallery.geometry.position = { x, y }
      	gallery.geometry.size = { w, h }
      	gallery.geometry.min_spacing = { sw, sh }
      	gallery.geometry.thumbnail_size = { tw, th }
      	gallery.geometry.ok = true
      	if not gallery.active then
      		return
      	end
      	if not gallery:enough_space() then
      		msg.warn("Not enough space to display something")
      	end
      	local old_total = gallery.geometry.rows * gallery.geometry.columns
      	gallery:compute_internal_geometry()
      	gallery:ensure_view_valid()
      	local new_total = gallery.geometry.rows * gallery.geometry.columns
      	for view_index = new_total + 1, old_total do
      		if gallery.overlays.active[view_index] then
      			mp.commandv("overlay-remove", gallery.config.overlay_range + view_index - 1)
      			gallery.overlays.active[view_index] = false
      		end
      	end
      	gallery:refresh_overlays(true)
      	gallery:ass_refresh(true, true, true, true)
      end

      function gallery_mt.items_changed(gallery, new_sel)
      	gallery.selection = math.max(1, math.min(new_sel, #gallery.items))
      	if not gallery.active then
      		return
      	end
      	gallery:ensure_view_valid()
      	gallery:refresh_overlays(false)
      	gallery:ass_refresh(true, true, true, false)
      end

      function gallery_mt.thumbnail_generated(gallery, thumb_path)
      	if not gallery.active then
      		return
      	end
      	local view_index = gallery.overlays.missing[thumb_path]
      	if view_index == nil then
      		return
      	end
      	gallery:show_overlay(view_index, thumb_path)
      	if not gallery.config.always_show_placeholders then
      		gallery:ass_refresh(false, false, true, false)
      	end
      	gallery.overlays.missing[thumb_path] = nil
      end

      function gallery_mt.add_generator(gallery, generator_name)
      	for _, g in ipairs(gallery.generators) do
      		if generator_name == g then
      			return
      		end
      	end
      	gallery.generators[#gallery.generators + 1] = generator_name
      end

      function gallery_mt.view_index_position(gallery, index_0)
      	local g = gallery.geometry
      	return math.floor(
      		g.position[1] + g.effective_spacing[1] + (g.effective_spacing[1] + g.thumbnail_size[1]) * (index_0 % g.columns)
      	),
      		math.floor(
      			g.position[2]
      				+ g.effective_spacing[2]
      				+ (g.effective_spacing[2] + g.thumbnail_size[2]) * math.floor(index_0 / g.columns)
      		)
      end

      function gallery_mt.enough_space(gallery)
      	if gallery.geometry.size[1] < gallery.geometry.thumbnail_size[1] + 2 * gallery.geometry.min_spacing[1] then
      		return false
      	end
      	if gallery.geometry.size[2] < gallery.geometry.thumbnail_size[2] + 2 * gallery.geometry.min_spacing[2] then
      		return false
      	end
      	return true
      end

      function gallery_mt.activate(gallery)
      	if gallery.active then
      		return false
      	end
      	if not gallery:enough_space() then
      		msg.warn("Not enough space, refusing to start")
      		return false
      	end
      	if not gallery.geometry.ok then
      		msg.warn("Gallery geometry unitialized, refusing to start")
      		return false
      	end
      	gallery.active = true
      	if not gallery.selection then
      		gallery:set_selection(1)
      	end
      	gallery:compute_internal_geometry()
      	gallery:ensure_view_valid()
      	gallery:refresh_overlays(false)
      	gallery:ass_refresh(true, true, true, true)
      	return true
      end

      function gallery_mt.deactivate(gallery)
      	if not gallery.active then
      		return
      	end
      	gallery.active = false
      	gallery:remove_overlays()
      	gallery.ass_show("")
      end

      return { gallery_new = gallery_new }
    '';
  };
}
