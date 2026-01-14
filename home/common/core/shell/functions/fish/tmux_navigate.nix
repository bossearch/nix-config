{
  TmuxNavigateLeft = ''
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateLeft<CR>"
      end
    end
  '';
  TmuxNavigateDown = ''
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateDown<CR>"
      end
    end
  '';
  TmuxNavigateUp = ''
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateUp<CR>"
      end
    end
  '';
  TmuxNavigateRight = ''
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateRight<CR>"
      end
    end
  '';
}
