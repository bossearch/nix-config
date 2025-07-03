{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];
  programs.yazi = {
    enable = true;
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.ROUNDED,
      })
      require("git"):setup()
      require("no-status"):setup()

      function Tabs.height()
        return 0
      end

      Header:children_add(function()
        if #cx.tabs == 1 then
          return ""
        end
        local spans = {}
        for i = 1, #cx.tabs do
          spans[#spans + 1] = ui.Span(" " .. i .. " ")
        end
        spans[cx.tabs.idx]:reverse()
        return ui.Line(spans)
      end, 9000, Header.RIGHT)

    '';
  };
}
