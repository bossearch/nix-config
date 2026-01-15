{
  TmuxNavigateLeft = ''
    printf "\033[A\033[2K"
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateLeft<CR>"
      end
    end
  '';
  TmuxNavigateDown = ''
    printf "\033[A\033[2K"
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateDown<CR>"
      end
    end
  '';
  TmuxNavigateUp = ''
    printf "\033[A\033[2K"
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateUp<CR>"
      end
    end
  '';
  TmuxNavigateRight = ''
    printf "\033[A\033[2K"
    for NVIM_SOCK in /run/user/1000/nvim.*
      if test -S "$NVIM_SOCK"
        nvim --server "$NVIM_SOCK" --remote-send "<C-\\><C-N>:TmuxNavigateRight<CR>"
      end
    end
  '';
}
