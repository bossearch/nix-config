{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableInteractive = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$all"
        "$fill"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](blue)";
        vimcmd_visual_symbol = "[❮](purple)";
      };
      fill = {
        symbol = " ";
      };
      cmd_duration = {
        style = "yellow";
        format = "took [$duration]($style)";
      };
      directory = {
        style = "blue";
        home_symbol = "~";
        use_os_path_sep = true;
        read_only = " 󰌾";
      };
    };
  };
}
