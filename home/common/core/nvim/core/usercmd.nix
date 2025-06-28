{
  programs.nixvim = {
    userCommands = {
      CopyRelativePath = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyAbsolutPath = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:p")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyRelativePathWithLine = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%")
              local line = vim.fn.line(".")
              local result = path .. ":" .. line
              require("lib.util").copy_to_clipboard(result, 'Copied "' .. result .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyAbsolutePathWithLine = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:p")
              local line = vim.fn.line(".")
              local result = path .. ":" .. line
              require("lib.util").copy_to_clipboard(result, 'Copied "' .. result .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyFileName = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:t")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      RootDir = {
        command = {
          __raw = ''
            function()
              local root = require("lib.util").get_root_dir()
              if root == "" then
                return
              end
              vim.cmd("lcd " .. root)
            end, {}
          '';
        };
      };
      LocalDir = {
        command = {
          __raw = ''
            function()
              local bufname = vim.fn.expand('%:p')
              if vim.fn.filereadable(bufname) == 0 then
                return
              end

              local file_dir = vim.fn.fnamemodify(bufname, ':h')
              vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))
            end, {}
          '';
        };
      };
    };
  };
}
