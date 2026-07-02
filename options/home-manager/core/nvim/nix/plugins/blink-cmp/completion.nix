{
  menu = {
    auto_show = true;
    draw = {
      padding = [1 0];
      columns.__raw = ''
        {{"label", "label_description", gap = 1}, {"kind", gap = 1, "kind_icon"}}
      '';
    };
  };

  accept = {
    auto_brackets = {
      enabled = false;
    };
  };

  list = {
    selection = {
      preselect = true;
      auto_insert = true;
    };
  };

  documentation = {
    auto_show = true;
    auto_show_delay_ms = 200;
  };

  ghost_text = {
    enabled = true;
  };
}
