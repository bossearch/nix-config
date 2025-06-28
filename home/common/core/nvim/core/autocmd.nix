{
  programs.nixvim = {
    autoCmd = [
      # Highlight on yank
      {
        event = ["TextYankPost"];
        pattern = ["*"];
        callback.__raw = ''
          function()
            vim.hl.on_yank()
          end
        '';
        desc = "Highlight selection on yank";
      }

      # Resize splits if window is resized
      {
        event = ["VimResized"];
        callback.__raw = ''
          function()
            vim.cmd("tabdo wincmd =")
          end
        '';
        desc = "Resize splits on window resize";
      }

      # Close some filetypes with <q>
      {
        event = ["FileType"];
        pattern = [
          "DressingSelect"
          "fugitive"
          "git"
          "help"
          "lir"
          "lspinfo"
          "man"
          "notify"
          "qf"
          "telescope"
          "health"
          "oil"
        ];
        callback.__raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
          end
        '';
        desc = "Close certain filetypes with <q>";
      }

      # Auto-create directory on save if necessary
      {
        event = ["BufWritePre"];
        callback.__raw = ''
          function(event)
            -- Get the file path
            local file = vim.uv.fs_realpath(event.match) or event.match
            -- Skip if the file is managed by oil.nvim (you can also check for filetype)
            if vim.bo.filetype == "oil" then
              return
            end
            -- Create the directory if necessary
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
        desc = "Auto-create directory before saving file";
      }

      # Remove trailing whitespace on save
      {
        event = ["BufWritePre"];
        pattern = ["*"];
        callback.__raw = ''
          function()
            local save_cursor = vim.fn.getpos(".")
            pcall(function() vim.cmd [[%s/\s\+$//e]] end)
            vim.fn.setpos(".", save_cursor)
          end
        '';
        desc = "Remove trailing whitespace on save";
      }

      # Set colorcolumn for git commit messages
      {
        event = ["FileType"];
        pattern = ["gitcommit"];
        callback.__raw = ''
          function()
            vim.opt_local.colorcolumn = { "50", "72" }
          end
        '';
        desc = "Set colorcolumn for git commit messages";
      }

      # Set custom hl for mini.base16
      {
        event = ["VimEnter"];
        callback.__raw = ''
          function()
            local p = require("lib.util").get_colorScheme()
            vim.api.nvim_set_hl(0, "CursorLineNr", {fg = p.base09, bg = p.base01 })
            vim.api.nvim_set_hl(0, "Normal", { fg = p.base05, bg = p.base00 })
            vim.api.nvim_set_hl(0, "NormalFloat", { fg = p.base05, bg = p.base01 })
            vim.api.nvim_set_hl(0, "NormalNC", { fg = p.base05, bg = p.base00 })
            vim.api.nvim_set_hl(0, "FloatBorder", {fg = p.base0F,  bg = p.base01 })
            vim.api.nvim_set_hl(0, "WarningMsg", { fg = p.base0A })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = p.base01, bg = "NONE" })
            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = p.base0A })
            vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = p.base0A })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { fg = p.base0A })
            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = p.base0F, bg = p.base01 })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = p.base0D, bg = p.base01 })
            vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = p.base0F, bg = p.base01 })

            vim.api.nvim_set_hl(0, "BlinkCmpMenu", {fg = p.base05, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", {fg = p.base0F, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {bg = p.base03})

            vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", {fg = p.base03, bg = p.base02})
            vim.api.nvim_set_hl(0, "BlinkCmpScrollBarGutter", {fg = p.base01, bg = p.base01})

            vim.api.nvim_set_hl(0, "BlinkCmpLabel", {fg = p.base05})
            vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", {fg = p.base03, strikethrough = true})
            vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", {fg = p.base0F, bold = true})
            vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", {fg = p.base04})
            vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", {fg = p.base03})

            vim.api.nvim_set_hl(0, "BlinkCmpSource", {fg = p.base04})
            vim.api.nvim_set_hl(0, "BlinkCmpGhostText", {fg = p.base03, italic = true})

            vim.api.nvim_set_hl(0, "BlinkCmpDoc", {fg = p.base05, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", {fg = p.base0F, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", {fg = p.base02})

            vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", {bg = p.base02})
            vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", {fg = p.base05, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", {fg = p.base0F, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", {fg = p.base0F, bold = true})

            vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", {fg = p.base07, bg = "NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindText",{fg=p.base07,bg="NONE"})

            vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", {fg = p.base08, bg = "NONE"})

            vim.api.nvim_set_hl(0,"BlinkCmpKindConstant",{fg=p.base09,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindBoolean",{fg=p.base09,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindEnumMember",{fg=p.base09,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindNumber",{fg=p.base09,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindObject",{fg=p.base09,bg="NONE"})

            vim.api.nvim_set_hl(0, "BlinkCmpKindFile", {fg = p.base0A, bg = p.base01})
            vim.api.nvim_set_hl(0, "BlinkCmpKindArray", {fg = p.base0A, bg = "NONE"})
            vim.api.nvim_set_hl(0, "BlinkCmpKindDefault", {fg = p.base0A, bg = "NONE"})

            vim.api.nvim_set_hl(0, "BlinkCmpKindValue", {fg = p.base0A, bg = "NONE"})
            vim.api.nvim_set_hl(0, "BlinkCmpKindString", {fg = p.base0A, bg = "NONE"})

            vim.api.nvim_set_hl(0, "BlinkCmpKindReference", {fg = p.base0B, bg = "NONE"})
            vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", {fg = p.base0B, bg = "NONE"})
            vim.api.nvim_set_hl(0, "BlinkCmpKindCodeium", {fg = p.base0B, bg = "NONE"})

            vim.api.nvim_set_hl(0,"BlinkCmpKindField",{fg=p.base0C,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindKey",{fg=p.base0C,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindProperty",{fg=p.base0C,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindOperator",{fg=p.base0C,bg="NONE"})

            vim.api.nvim_set_hl(0,"BlinkCmpKindFolder",{fg=p.base0D,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindFunction",{fg=p.base0D,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindMethod",{fg=p.base0D,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindModule",{fg=p.base0D,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindNamespace",{fg=p.base0D,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindPackage",{fg=p.base0D,bg="NONE"})

            vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", {fg = p.base0E, bg = "NONE"})
            vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", {fg = p.base0E, bg = "NONE"})

            vim.api.nvim_set_hl(0,"BlinkCmpKindEnum",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindEvent",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindNull",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindInterface",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindStruct",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindTypeParameter",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindUnit",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindColor",{fg=p.base0F,bg="NONE"})
            vim.api.nvim_set_hl(0,"BlinkCmpKindClass",{fg=p.base0F,bg="NONE"})
          end
        '';
      }
    ];
  };
}
