let
  buffer_score = 60;
  dictionary_score = 40;
  git_score = 90;
  lsp_score = 90;
  path_score = 70;
  ripgrep_score = 50;
  snippets_score = 80;
  thesaurus_score = 20;
in {
  default = [
    "buffer"
    "dictionary"
    # "git"
    "lsp"
    "path"
    "ripgrep"
    "snippets"
    "thesaurus"
  ];
  providers = {
    buffer = {
      name = "buff";
      module = "blink.cmp.sources.buffer";
      enabled = true;
      async = true;
      max_items = 4;
      min_keyword_length = 2;
      score_offset = buffer_score;
      opts = {
        get_bufnrs.__raw = ''
          function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ""
            end, vim.api.nvim_list_bufs())
          end
        '';
      };
    };
    dictionary = {
      name = "dict";
      module = "blink-cmp-words.dictionary";
      enabled.__raw = ''
        function()
          return vim.tbl_contains({ 'gitcommit', 'markdown' }, vim.bo.filetype)
        end
      '';
      opts = {
        score_offset = dictionary_score;
        dictionary_search_threshold = 3;
        definition_pointers = ["!" "&" "^"];
      };
    };
    git = {
      name = "git";
      module = "blink-cmp-git";
      enabled.__raw = ''
        function()
          return vim.tbl_contains({ 'gitcommit' }, vim.bo.filetype)
        end
      '';
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
      async = true;
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
        show_hidden_files_by_default = true;
        trailing_slash = false;
        get_cwd.__raw = ''
          function(_)
            return vim.fn.getcwd()
          end
        '';
      };
    };
    ripgrep = {
      name = "grep";
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
    # TODO: refine this sections
    snippets = {
      name = "snip";
      module = "blink.cmp.sources.snippets";
      enabled = true;
      async = false;
      max_items = 5;
      min_keyword_length = 2;
      score_offset = snippets_score;
      opts = {
        use_show_condition = true;
        show_autosnippets = true;
      };
    };
    thesaurus = {
      name = "thes";
      module = "blink-cmp-words.thesaurus";
      enabled.__raw = ''
        function()
          return vim.tbl_contains({ 'gitcommit', 'markdown' }, vim.bo.filetype)
        end
      '';
      opts = {
        definition_pointers = ["!" "&" "^"];
        similarity_pointers = ["&" "^"];
        similarity_depth = 2;
        score_offset = thesaurus_score;
      };
    };
  };
}
