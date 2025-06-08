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
      preset = "helix"; # classic, modern, or helix
      triggers.__raw = ''
        {
          { "<leader>", mode = { "n", "v" } },
          { "[", mode = { "n", "v" } },
          { "]", mode = { "n", "v" } },
        }
      '';
      spec =
        (import ./siuu.nix)
        ++ (import ./gitsigns.nix)
        ++ (import ./lsp.nix)
        ++ (import ./markdown.nix)
        ++ (import ./neo.nix)
        ++ (import ./picker.nix)
        ++ (import ./quickfix.nix)
        ++ (import ./toggle.nix)
        ++ (import ./window.nix);
    };
  };
}
