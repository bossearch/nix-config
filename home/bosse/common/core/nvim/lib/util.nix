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
          local file = io.open("/tmp/nvim-startup.log", "r")
          if file then
            for line in file:lines() do
              if line:find("NVIM STARTED") then
                local ms = line:match("([%d%.]+)")
                if ms and tonumber(ms) > 10 then
                  last_ms = ms
                end
              end
            end
            file:close()
          end

          if last_ms then
            return string.format(
              "%.2fms",
              tonumber(last_ms)
            )
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

          -- Path to your tips file
          local tips_file = vim.fn.stdpath('config') .. '/lua/lib/tips.lua'

          -- Try to load the tips list
          local ok, tips = pcall(dofile, tips_file)
          if not ok or type(tips) ~= "table" or #tips == 0 then
            return "No tips available!"
          end

          -- Randomly select a tip
          math.randomseed(os.time() + math.random(1000000))
          local tip = tips[math.random(1, #tips)]

          return wrap_text(tip, 60)
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

        return util
      '';
    };
  };
}
