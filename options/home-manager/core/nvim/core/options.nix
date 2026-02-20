{
  programs.nixvim = {
    # clipboard settings
    extraConfigLua = ''
      if vim.env.SSH_CONNECTION then
        vim.g.clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
          },
          paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
          },
        }
        vim.keymap.set({"n","v"}, "y", "\"+y", { noremap = true, silent = true })
      else
        vim.o.clipboard = "unnamedplus"
      end
    '';
    opts = {
      confirm = true; # Confirm to save changes before exiting modified buffer
      cursorcolumn = false; # Highlight the screen column of the cursor
      cursorline = true; # Highlight the screen line of the cursor
      cursorlineopt = "number"; # cursorline opt
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      foldlevel = 99; # Folds level when scrolling
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      jumpoptions = "view"; # restore position when jumping
      laststatus = 3; # When to use a status line for the last window
      linebreak = true; # Wrap lines at convenient points
      list = true; # Show some invisible characters (tabs...
      mouse = "a"; # Enable mouse mode
      number = true; # Display the absolute line number of the current line
      pumblend = 10; # Popup blend
      pumheight = 10; # Maximum number of entries in a popup
      relativenumber = true; # Relative line numbers
      ruler = false; # Disable the default ruler
      scrolloff = 10; # Number of screen lines to show around the cursor
      shiftround = true; # Round indent
      shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
      showmode = false; # Dont show mode since we have a statusline
      sidescrolloff = 8; # Columns of context
      signcolumn = "yes"; # # Whether to show the signcolumn
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
      smoothscroll = true; # self explained
      splitbelow = true; # A new window is put below the current one
      splitkeep = "screen";
      splitright = true; # A new window is put right of the current one
      swapfile = false; # Disable the swap file
      tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|
      undofile = true; # Automatically save and restore undo history
      virtualedit = "block"; # Allow cursor to move where there is no text in visual block mode
      winminwidth = 5; # Minimum window width
      wrap = false; # line wrap
    };
  };
}
