{
  highlight_duration = 500;
  mappings = {
    add = "sa"; # Add surrounding in Normal and Visual modes
    delete = "sd"; # Delete surrounding
    find = "sf"; # Find surrounding (to the right)
    find_left = "sF"; # Find surrounding (to the left)
    replace = "sr"; # Replace surrounding
    highlight = ""; # Highlight surrounding
    update_n_lines = ""; # Update `n_lines`

    suffix_last = "p"; # Suffix to search with "prev" method
    suffix_next = "n"; # Suffix to search with "next" method
  };
  n_lines = 60;
  respect_selection_type = false;
  search_method = "cover";
  silent = true;
}
