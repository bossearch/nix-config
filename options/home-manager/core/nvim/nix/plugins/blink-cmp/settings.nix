{
  keymap.__raw = ''
    {
      preset = "none",
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
    }
  '';
  snippets = {
    preset = "luasnip";
  };
  signature = {
    enabled = false;
  };
  appearance = import ./appearance.nix;
  cmdline = import ./cmdline.nix;
  completion = import ./completion.nix;
  sources = import ./sources.nix;
  term.enabled = false;
}
