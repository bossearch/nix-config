{
  config,
  homes,
  hosts,
  lib,
  ...
}: let
  base00 = "${config.colorScheme.palette.base00}";
  base01 = "${config.colorScheme.palette.base01}";
  base03 = "${config.colorScheme.palette.base03}";
  base05 = "${config.colorScheme.palette.base03}";
  base07 = "${config.colorScheme.palette.base07}";
  base08 = "${config.colorScheme.palette.base08}";
  base0A = "${config.colorScheme.palette.base0A}";
  base0B = "${config.colorScheme.palette.base0B}";
  base0C = "${config.colorScheme.palette.base0C}";
  base0D = "${config.colorScheme.palette.base0D}";
  base0E = "${config.colorScheme.palette.base0E}";
  base0F = "${config.colorScheme.palette.base0F}";
  size = "size=12";
  features =
    if homes.nerdfont == "CommitMono"
    then "antialias=true:fontfeatures=ss03:fontfeatures=ss04:fontfeatures=ss05::fontfeatures=cv02=1:fontfeatures=cv05=1"
    else "antialias=true";
in {
  programs.foot = {
    enable = hosts.gui.enable;
    server.enable = true;
    settings = {
      "colors-dark" = {
        background = base01;
        foreground = base07;

        regular0 = base00;
        regular1 = base08;
        regular2 = base0B;
        regular3 = base0A;
        regular4 = base0D;
        regular5 = base0E;
        regular6 = base0C;
        regular7 = base05;

        bright0 = base03;
        bright1 = base08;
        bright2 = base0B;
        bright3 = base0A;
        bright4 = base0D;
        bright5 = base0E;
        bright6 = base0C;
        bright7 = base07;

        cursor = "${base01} ${base07}";
        selection-foreground = base01;
        selection-background = base07;
        scrollback-indicator = "${base0F} ${base01}";
        urls = base0F;
      };
      cursor = {
        style = "block";
        blink = "yes";
      };
      key-bindings = {
        clipboard-copy = "XF86Copy";
        clipboard-paste = "XF86Paste";
        search-start = "none";
        font-increase = "Control+plus";
        font-decrease = "Control+minus";
        font-reset = "Control+equal";
      };
      main = {
        shell = "/usr/bin/env ${hosts.shell}";
        term = "xterm-256color";
        font = "${homes.nerdfont} Nerd Font:${size}:${features}";
        font-bold = "${homes.nerdfont} Nerd Font:style=Bold:${size}:${features}";
        font-italic = "${homes.nerdfont} Nerd Font:style=Italic:${size}:${features}";
        font-bold-italic = "${homes.nerdfont} Nerd Font:style=Bold Italic:${size}:${features}";
        dpi-aware = "no";
        pad = "0x0";
        line-height = 16;
      };
      mouse = {
        hide-when-typing = "no";
      };
      mouse-bindings = {
        select-begin-block = "none";
        select-extend-character-wise = "none";
        select-word = "none";
        select-word-whitespace = "BTN_LEFT-2";
      };
      scrollback = {
        lines = "10000";
        multiplier = "1.0";
        indicator-position = "relative";
        indicator-format = "|";
      };
      security = {
        osc52 = "enabled";
      };
      url = {
        launch = "xdg-open \${url}";
        osc8-underline = "always";
        regex = "(((https?://|mailto:|ftp://|file:|ssh:|ssh://|git://|tel:|magnet:|ipfs://|ipns://|gemini://|gopher://|news:)|www\.)([0-9a-zA-Z:/?#@!$&*+,;=.~_%^\-]+|\([]\[\"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\)|\[[\(\)\"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\]|\"[]\[\(\)0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\"|'[]\[\(\)0-9a-zA-Z:/?#@!$&*+,;=.~_%^\-]*')+([0-9a-zA-Z/#@$&*+=~_%^\-]|\([]\[\"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\)|\[[\(\)\"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\]|\"[]\[\(\)0-9a-zA-Z:/?#@!$&'*+,;=.~_%^\-]*\"|'[]\[\(\)0-9a-zA-Z:/?#@!$&*+,;=.~_%^\-]*'))";
      };
    };
  };
  home.file.".config/foot/footclient.sh" = lib.mkIf config.programs.foot.enable {
    executable = true;
    text = ''
      #!/usr/bin/env ${hosts.shell}

      dbus-update-activation-environment --systemd FZF_DEFAULT_OPTS
      systemctl --user restart foot.service
    '';
  };
}
