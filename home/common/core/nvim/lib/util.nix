{config, ...}: {
  programs.nixvim = {
    extraFiles = {
      "lua/lib/util.lua".text = ''
        local util = {}

        -- usercmd --
        util.copy_to_clipboard = function(content)
          vim.fn.setreg("+", content)
          vim.notify('Copied "' .. content .. '" to the clipboard!', vim.log.levels.INFO)
        end

        -- usercmd --
        util.get_root_dir = function()
            local bufname = vim.fn.expand('%:p')
            if vim.fn.filereadable(bufname) == 0 then
                return
            end

            local parent = vim.fn.fnamemodify(bufname, ':h')
            local git_root = vim.fn.systemlist('git -C ' .. parent .. ' rev-parse --show-toplevel')
            if #git_root > 0 and git_root[1] ~= ''\'' then
                return git_root[1]
            else
                return parent
            end
        end

        -- lualine --
        util.get_cwd = function()
          local cwd = vim.fn.getcwd()
          local folder_name = vim.fn.fnamemodify(cwd, ":t")
          return folder_name
        end

        -- lualine --
        local spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        local client_progress = {}

        -- Configurable options
        local opts = {
          show_default_progress = true, -- Set to false to hide Neovim's default LSP progress UI
        }

        -- Save the original handler so we can optionally call it
        local orig_progress_handler = vim.lsp.handlers["$/progress"]

        -- Hook into $/progress notifications to track status per client
        vim.lsp.handlers["$/progress"] = function(err, msg, ctx)
          local client_id = ctx.client_id
          local token = msg.token
          local value = msg.value

          if not client_progress[client_id] then
            client_progress[client_id] = {}
          end

          if value.kind == "begin" then
            client_progress[client_id][token] = true
          elseif value.kind == "end" then
            client_progress[client_id][token] = nil
          end

          -- Clean up empty tables
          if next(client_progress[client_id]) == nil then
            client_progress[client_id] = nil
          end

          -- Conditionally call the original handler
          if opts.show_default_progress and orig_progress_handler then
            orig_progress_handler(err, msg, ctx)
          end
        end

        -- Status function with proper spinner
        util.lsp_status = function()
          local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
          if #clients == 0 then
            return "No LSP"
          end

          local hrtime = (vim.uv or vim.loop).hrtime
          local frame = spinner_symbols[(math.floor(hrtime() / (1e6 * 100)) % #spinner_symbols) + 1]

          local results = {}
          for _, client in ipairs(clients) do
            local show_spinner = client_progress[client.id] ~= nil
            local icon = show_spinner and frame or "✓"
            table.insert(results, client.name .. " " .. icon)
          end

          return table.concat(results, " ")
        end

        -- startup-time --
        util.get_nvim_startup_time = function()
          local last_ms = nil
          local last_started_line = nil

          local file = io.open("/tmp/nvim-startup.log", "r")
          if file then
            for line in file:lines() do
              if line:find("NVIM STARTED") then
                local ms = line:match("([%d%.]+)")
                if ms and tonumber(ms) > 10 then
                  last_ms = ms
                  last_started_line = line -- store the line exactly
                end
              end
            end
            file:close()
          end

          if last_started_line then
            local new_file = io.open("/tmp/nvim-startup.log", "w")
            new_file:write(last_started_line .. "\n")
            new_file:close()
          end

          if last_ms then
            return string.format("%.2fms", tonumber(last_ms))
          else
            return "???"
          end
        end

        -- tips --
        util.get_tips = function ()
          local function wrap_text(text, max_width)
            local lines, current = {}, ""
            for line in text:gmatch("[^\n]+") do
              for word in line:gmatch("%S+") do
                if #current == 0 then
                  current = word
                elseif #current + #word + 1 <= max_width then
                  current = current .. " " .. word
                else
                  table.insert(lines, current)
                  current = word
                end
              end
              if #current > 0 then
                table.insert(lines, current)
                current = ""
              end
            end
            return table.concat(lines, "\n")
          end

          local tips_file = vim.fn.stdpath('config') .. '/lua/lib/tips.lua'

          local ok, tips = pcall(dofile, tips_file)
          if not ok or type(tips) ~= "table" or #tips == 0 then
            return "No tips available!"
          end

          math.randomseed(os.time() + math.random(1000000))
          local tip = tips[math.random(1, #tips)]

          return wrap_text(tip, 60)
        end

        -- smart buffer delete --
        util.smart_bdelete = function()
          if vim.bo.filetype == "Fyler" then
            vim.cmd("TmuxNavigateRight")
            return
          end
          if (vim.api.nvim_win_get_width(0) < (vim.o.columns - 37)) or
            (vim.api.nvim_win_get_height(0) < 64) then
              vim.cmd("close")
          else
            vim.cmd("bnext")
            local alt_bufnr = tonumber(vim.fn.bufnr("#"))
            if alt_bufnr > 0 and vim.api.nvim_buf_is_valid(alt_bufnr) then
              vim.api.nvim_buf_delete(alt_bufnr, { force = false })
            else
              vim.cmd("quitall")
            end
          end
        end

        -- fix fyler width
        util.fyler_width = function(file_win)
          vim.schedule(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "Fyler" then
                fyler_win = win
                break
              end
            end

            if fyler_win and vim.api.nvim_win_is_valid(fyler_win) then
              vim.api.nvim_win_set_option(fyler_win, "winfixwidth", true)
            end

            if vim.api.nvim_win_is_valid(file_win) then
              vim.api.nvim_set_current_win(file_win)
            end
          end)
        end

        -- palette --
        util.get_colorScheme = function()
          return{
            base00 = "#${config.colorScheme.palette.base00}",
            base01 = "#${config.colorScheme.palette.base01}",
            base02 = "#${config.colorScheme.palette.base02}",
            base03 = "#${config.colorScheme.palette.base03}",
            base04 = "#${config.colorScheme.palette.base04}",
            base05 = "#${config.colorScheme.palette.base05}",
            base06 = "#${config.colorScheme.palette.base06}",
            base07 = "#${config.colorScheme.palette.base07}",
            base08 = "#${config.colorScheme.palette.base08}",
            base09 = "#${config.colorScheme.palette.base09}",
            base0A = "#${config.colorScheme.palette.base0A}",
            base0B = "#${config.colorScheme.palette.base0B}",
            base0C = "#${config.colorScheme.palette.base0C}",
            base0D = "#${config.colorScheme.palette.base0D}",
            base0E = "#${config.colorScheme.palette.base0E}",
            base0F = "#${config.colorScheme.palette.base0F}",
          }
        end

        -- custom highlight for mini.base16 --
        util.set_highlights = function()
          local p = util.get_colorScheme()

          local hl = vim.api.nvim_set_hl
          hl(0, "CursorLineNr", { fg = p.base09, bg = p.base01 })
          hl(0, "Normal", { fg = p.base05, bg = p.base00 })
          hl(0, "NormalFloat", { fg = p.base05, bg = p.base01 })
          hl(0, "NormalNC", { fg = p.base05, bg = p.base00 })
          hl(0, "FloatBorder", { fg = p.base0F, bg = p.base01 })
          hl(0, "WarningMsg", { fg = p.base0A })
          hl(0, "WinSeparator", { fg = p.base01, bg = "NONE" })
          hl(0, "DiagnosticWarn", { fg = p.base0A })
          hl(0, "DiagnosticFloatingWarn", { fg = p.base0A })
          hl(0, "DiagnosticUnderlineWarn", { fg = p.base0A })
          hl(0, "GitSignsAdd", { fg = p.base0F, bg = p.base01 })
          hl(0, "GitSignsChange", { fg = p.base0D, bg = p.base01 })
          hl(0, "GitSignsUntracked", { fg = p.base0F, bg = p.base01 })

          hl(0, "BlinkCmpMenu", { fg = p.base05, bg = p.base01 })
          hl(0, "BlinkCmpMenuBorder", { fg = p.base0F, bg = p.base01 })
          hl(0, "BlinkCmpMenuSelection", { bg = p.base03 })

          hl(0, "BlinkCmpScrollBarThumb", { fg = p.base03, bg = p.base02 })
          hl(0, "BlinkCmpScrollBarGutter", { fg = p.base01, bg = p.base01 })

          hl(0, "BlinkCmpLabel", { fg = p.base05 })
          hl(0, "BlinkCmpLabelDeprecated", { fg = p.base03, strikethrough = true })
          hl(0, "BlinkCmpLabelMatch", { fg = p.base0F, bold = true })
          hl(0, "BlinkCmpLabelDetail", { fg = p.base04 })
          hl(0, "BlinkCmpLabelDescription", { fg = p.base03 })

          hl(0, "BlinkCmpSource", { fg = p.base04 })
          hl(0, "BlinkCmpGhostText", { fg = p.base03, italic = true })

          hl(0, "BlinkCmpDoc", { fg = p.base05, bg = p.base01 })
          hl(0, "BlinkCmpDocBorder", { fg = p.base0F, bg = p.base01 })
          hl(0, "BlinkCmpDocSeparator", { fg = p.base02 })

          hl(0, "BlinkCmpDocCursorLine", { bg = p.base02 })
          hl(0, "BlinkCmpSignatureHelp", { fg = p.base05, bg = p.base01 })
          hl(0, "BlinkCmpSignatureHelpBorder", { fg = p.base0F, bg = p.base01 })
          hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = p.base0F, bold = true })

          hl(0, "BlinkCmpKindVariable", { fg = p.base07, bg = "NONE" })
          hl(0, "BlinkCmpKindText", { fg = p.base07, bg = "NONE" })

          hl(0, "BlinkCmpKindSnippet", { fg = p.base08, bg = "NONE" })

          hl(0, "BlinkCmpKindConstant", { fg = p.base09, bg = "NONE" })
          hl(0, "BlinkCmpKindBoolean", { fg = p.base09, bg = "NONE" })
          hl(0, "BlinkCmpKindEnumMember", { fg = p.base09, bg = "NONE" })
          hl(0, "BlinkCmpKindNumber", { fg = p.base09, bg = "NONE" })
          hl(0, "BlinkCmpKindObject", { fg = p.base09, bg = "NONE" })

          hl(0, "BlinkCmpKindFile", { fg = p.base0A, bg = p.base01 })
          hl(0, "BlinkCmpKindArray", { fg = p.base0A, bg = "NONE" })
          hl(0, "BlinkCmpKindDefault", { fg = p.base0A, bg = "NONE" })

          hl(0, "BlinkCmpKindValue", { fg = p.base0A, bg = "NONE" })
          hl(0, "BlinkCmpKindString", { fg = p.base0A, bg = "NONE" })

          hl(0, "BlinkCmpKindReference", { fg = p.base0B, bg = "NONE" })
          hl(0, "BlinkCmpKindCopilot", { fg = p.base0B, bg = "NONE" })
          hl(0, "BlinkCmpKindCodeium", { fg = p.base0B, bg = "NONE" })

          hl(0, "BlinkCmpKindField", { fg = p.base0C, bg = "NONE" })
          hl(0, "BlinkCmpKindKey", { fg = p.base0C, bg = "NONE" })
          hl(0, "BlinkCmpKindProperty", { fg = p.base0C, bg = "NONE" })
          hl(0, "BlinkCmpKindOperator", { fg = p.base0C, bg = "NONE" })

          hl(0, "BlinkCmpKindFolder", { fg = p.base0D, bg = "NONE" })
          hl(0, "BlinkCmpKindFunction", { fg = p.base0D, bg = "NONE" })
          hl(0, "BlinkCmpKindMethod", { fg = p.base0D, bg = "NONE" })
          hl(0, "BlinkCmpKindModule", { fg = p.base0D, bg = "NONE" })
          hl(0, "BlinkCmpKindNamespace", { fg = p.base0D, bg = "NONE" })
          hl(0, "BlinkCmpKindPackage", { fg = p.base0D, bg = "NONE" })

          hl(0, "BlinkCmpKindKeyword", { fg = p.base0E, bg = "NONE" })
          hl(0, "BlinkCmpKindConstructor", { fg = p.base0E, bg = "NONE" })

          hl(0, "BlinkCmpKindEnum", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindEvent", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindNull", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindInterface", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindStruct", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindTypeParameter", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindUnit", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindColor", { fg = p.base0F, bg = "NONE" })
          hl(0, "BlinkCmpKindClass", { fg = p.base0F, bg = "NONE" })

          hl(0, "FylerFSDirectoryIcon", { fg = p.base0D, bg = "NONE" })
          hl(0, "FylerFSDirectoryName", { fg = p.base0D, bg = "NONE" })
          hl(0, "FylerFSFile", { fg = p.base05, bg = "NONE" })
          hl(0, "FylerIndentMarker", { fg = p.base03, bg = "NONE" })
          hl(0, "FylerConfirmGreen", { fg = p.base0B, bg = "NONE" })
          hl(0, "FylerConfirmRed", { fg = p.base08, bg = "NONE" })
          hl(0, "FylerConfirmYellow", { fg = p.base0A, bg = "NONE" })
          hl(0, "FylerConfirmGrey", { fg = p.base04, bg = "NONE" })
          hl(0, "FylerBorder", { fg = p.base0F, bg = "NONE" })

          hl(0, "AvanteTitle", { fg = p.base01, bg = p.base0B })
          hl(0, "AvanteSubtitle", { fg = p.base01, bg = p.base0C })
          hl(0, "AvanteThirdTitle", { fg = p.base01, bg = p.base03 })
          hl(0, "AvanteReversedTitle", { fg = p.base0B, bg = p.base01 })
          hl(0, "AvanteReversedSubtitle", { fg = p.base0C, bg = p.base01 })
          hl(0, "AvanteReversedThirdTitle", { fg = p.base03, bg = p.base01 })
          hl(0, "AvanteSidebarWinSeparator", { fg = p.base00, bg = p.base01 })
          hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = p.base01, bg = p.base01 })

          hl(0, "SnacksPickerDir", { fg = p.base0D, bg = "NONE" })
        end

        return util
      '';
    };
  };
}
