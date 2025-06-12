{
  config,
  inputs,
  pkgs,
  ...
}: let
  base09 = "${config.lib.stylix.colors.withHashtag.base09}";
  base0F = "${config.lib.stylix.colors.withHashtag.base0F}";
in {
  imports = [
    inputs.nyaa.homeManagerModule
  ];

  home.packages = with pkgs; [
    transmission_4-gtk
  ];

  programs.nyaa = {
    enable = true;
    default_theme = "TokyoNight";
    default_source = "Nyaa";
    download_client = "Transmission";
    timeout = 30;
    scroll_padding = 3;
    cursor_padding = 4;
    client.transmission = {
      base_url = "http://localhost:9091/transmission/rpc";
      username = "bosse";
      password_file = "/home/bosse/Documents/obsidian-vault/05 - Permanent/transmission-password.md";
      use_magnet = true;
      download_dir = "/home/bosse/Videos/Anime/";
    };
  };

  home.file.".config/nyaa/themes/TokyoNight.toml".text = ''
    name = "TokyoNight"
    bg = "Reset"
    fg = "White"
    border = "Rounded"
    border_color = ${base0F}
    border_focused_color = ${base09}
    hl_bg = "Gray"
    solid_bg = "White"
    solid_fg = "Black"
    success = "Green"
    error = "Red"
    info = "Blue"
    warning = "Yellow"
  '';
}
