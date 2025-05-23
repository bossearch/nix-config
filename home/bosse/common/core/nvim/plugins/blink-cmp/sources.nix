let
  buffer_score = 50;
  copilot_score = 60;
  dictionary_score = 30;
  git_score = 90;
  lsp_score = 70;
  path_score = 80;
  ripgrep_score = 40;
  snippets_score = 100;
in{
  default = [
    "buffer"
    "cmdline"
    "copilot"
    "dictionary"
    "git"
    "lsp"
    "path"
    "ripgrep"
    "snippets"
  ];

  providers = {
    buffer = {
      name = "buffer";
      module = "blink.cmp.sources.buffer";
      enabled = true;
      async = true;
      max_items = 4;
      min_keyword_length = 2;
      score_offset = buffer_score;
    };
    copilot = {
      name = "copilot";
      module = "blink-copilot";
      enabled = true;
      async = true;
      min_keyword_length = 4;
      score_offset = copilot_score;
      opts = {
        max_completions = 2;
        max_attempts = 4;
        kind = "Copilot";
        debounce = 750;
        auto_refresh = {
          backward = true;
          forward = true;
        };
      };
    };
    dictionary = {
      name = "dict";
      module = "blink-cmp-dictionary";
      # only enable this source when filetype is gitcommit, markdown, or 'octo'
      enabled.__raw = ''
        function()
          return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
        end
      '';
      async = true;
      max_items = 4;
      min_keyword_length = 3;
      score_offset = dictionary_score;
      opts = {
        dictionary_files.__raw = ''
          { vim.fn.expand("~/.config/nvim/lua/lib/words.txt") }
        '';
      };
    };
    git = {
      name = "git";
      module = "blink-cmp-git";
      # only enable this source when filetype is gitcommit, markdown, or 'octo'
      enabled.__raw = ''
        function()
          return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
        end
      '';
      async = true;
      max_items = null;
      min_keyword_length = 1;
      score_offset = git_score;
      opts = {
        commit = {};
        git_centers = {github = {};};
      };
    };
    lsp = {
      name = "lsp";
      module = "blink.cmp.sources.lsp";
      enabled = true;
      async = false;
      max_items = null;
      min_keyword_length = 0;
      score_offset = lsp_score;
      timeout_ms = 2000;
      fallbacks = [
        "buffer"
      ];
    };
    path = {
      name = "path";
      module = "blink.cmp.sources.path";
      enabled = true;
      async = true;
      max_items = null;
      min_keyword_length = 0;
      score_offset = path_score;
      fallbacks = [
        "buffer"
      ];
      opts = {
        label_trailing_slash = true;
        show_hidden_files_by_default = false;
        trailing_slash = false;
      };
    };
    ripgrep = {
      name = "ripgrep";
      module = "blink-ripgrep";
      enabled = true;
      async = true;
      score_offset = ripgrep_score;
      opts = {
        prefix_min_len = 3;
        context_size = 5;
        max_filesize = "1M";
        project_root_marker = ".git";
        project_root_fallback = true;
        search_casing = "--ignore-case";
        additional_rg_options = {};
        fallback_to_regex_highlighting = true;
        ignore_paths = {};
        additional_paths = {};
        debug = false;
      };
    };
    snippets = {
      name = "snippets";
      module = "blink.cmp.sources.snippets";
      enabled = false;
      async = true;
      max_items = 15;
      min_keyword_length = 2;
      score_offset = snippets_score;
    };
  };
}
