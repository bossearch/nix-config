{
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
        local opts = {
          show_default_progress = true, -- Set to false to hide Neovim's default LSP progress UI
        }
        local orig_progress_handler = vim.lsp.handlers["$/progress"]

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

          if next(client_progress[client_id]) == nil then
            client_progress[client_id] = nil
          end

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
          if vim.bo.filetype == "fyler" then
            vim.cmd("TmuxNavigateRight")
            return
          end
          if (vim.api.nvim_win_get_width(0) < (vim.o.columns - 37)) or
            (vim.api.nvim_win_get_height(0) < (vim.o.lines - 1)) then
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

        return util
      '';
    };
  };
}
