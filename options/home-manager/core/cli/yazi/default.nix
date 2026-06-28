{mylib, ...}: {
  imports = mylib.autoimport ./.;

  programs.yazi = {
    enable = true;
    # disable yazi.shellWrapperName
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.ROUNDED,
      })
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

      function Linemode:size_and_mtime()
          local time = math.floor(self._file.cha.mtime or 0)
          local time_str = ""
          if time > 0 then
              time_str = os.date("%Y/%b/%d %H:%M", time)
          end
          local size = self._file:size()
          return string.format("%s %s", size and ya.readable_size(size) or "-", time_str)
      end
    '';
  };
}
