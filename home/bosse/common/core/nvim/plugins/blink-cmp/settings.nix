{
  keymap.__raw = ''
    {
      preset = "none",
      ['<Tab>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
      ['<Right>'] = { 'select_and_accept', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Left>'] = { 'hide', 'fallback' },
    }
  '';
  snippets = {
    preset = "luasnip";
  };
  signature = {
    enabled = true;
    window = {
      border = "rounded";
    };
  };
  appearance = import ./appearance.nix;
  cmdline = import ./cmdline.nix;
  completion = import ./completion.nix;
  sources = import ./sources.nix;
}
