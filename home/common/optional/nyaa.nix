{
  config,
  inputs,
  pkgs,
  ...
}: let
  base03 = "#${config.colorScheme.palette.base03}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  imports = [
    inputs.nyaa.homeManagerModule
  ];

  home.packages = with pkgs; [
    transmission_4-gtk
  ];

  programs.nyaa = {
    enable = true;
    default_theme = "palette";
    default_source = "Nyaa";
    download_client = "Transmission";
    timeout = 30;
    scroll_padding = 3;
    cursor_padding = 4;
    client.transmission = {
      base_url = "http://localhost:9091/transmission/rpc";
      username = "${config.spec.userName}";
      password_file = "${config.home.homeDirectory}/.cache/${config.spec.userName}/transmission";
      use_magnet = true;
      download_dir = "${config.home.homeDirectory}/Videos/Anime/";
    };
  };

  home.file.".config/nyaa/themes/palette.toml".text = ''
    name = "palette"
    bg = "Reset"
    fg = "White"
    border = "Rounded"
    border_color = "${base0F}"
    border_focused_color = "${base09}"
    hl_bg = "${base03}"
    solid_bg = "White"
    solid_fg = "Black"
    success = "Green"
    error = "Red"
    info = "Blue"
    warning = "Yellow"
  '';
}
