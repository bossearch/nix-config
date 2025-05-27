# TODO: Try adding all key to keymaps except groups
{
  programs.nixvim.plugins.which-key = {
    enable = true;
    lazyLoad = {
      settings = {
        cmd = "WhichKey";
        event = "UIEnter";
      };
    };
    settings = {
      delay = 200;
      expand = 1;
      notify = true;
      preset = "classic"; # classic, modern, or helix
      triggers.__raw = ''
        {
          { "<leader>", mode = { "n", "v" } },
          { "[", mode = { "n", "v" } },
          { "]", mode = { "n", "v" } },
        }
      '';
      spec =
        (import ./file.nix)
        ++ (import ./gitsigns.nix)
        ++ (import ./lsp.nix)
        ++ (import ./markdown.nix)
        ++ (import ./neo.nix)
        ++ (import ./other.nix)
        ++ (import ./picker.nix)
        ++ (import ./quickfix.nix)
        ++ (import ./split.nix)
        ++ (import ./terminal.nix)
        ++ (import ./tree.nix)
        ++ (import ./window.nix);
    };
  };
}
