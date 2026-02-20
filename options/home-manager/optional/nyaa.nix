{
  config,
  homes,
  hosts,
  inputs,
  lib,
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

  programs.nyaa = {
    enable = homes.nyaa;
    default_theme = "palette";
    default_source = "Nyaa";
    # download_client = "RunCommand";
    download_client = "Transmission";
    timeout = 30;
    scroll_padding = 3;
    cursor_padding = 4;
    client.transmission = {
      base_url = "http://localhost:9091/transmission/rpc";
      username = "${hosts.username}";
      password_file = "${config.home.homeDirectory}/.cache/${hosts.username}/transmission";
      use_magnet = true;
      download_dir = "${config.home.homeDirectory}/Downloads/Torrent/";
    };
  };

  home = lib.mkIf homes.nyaa {
    packages = with pkgs; [
      transmission_4-gtk
    ];
    file.".config/nyaa/themes/palette.toml".text = ''
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
  };

  xdg.desktopEntries.transmission = lib.mkIf homes.nyaa {
    type = "Application";
    name = "transmission-gtk";
    exec = "transmission-gtk %U";
    noDisplay = true;
    terminal = false;
    comment = "Custom definition for transmission-gtk";
    mimeType = [
      "application/x-bittorrent"
      "x-scheme-handler/magnet"
    ];
  };
}
