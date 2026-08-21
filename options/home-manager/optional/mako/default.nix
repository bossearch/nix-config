{
  config,
  homes,
  hosts,
  mylib,
  pkgs,
  ...
}: let
  base00 = "#${config.colorScheme.palette.base00}b3";
  base01 = "#${config.colorScheme.palette.base01}80";
  base05 = "#${config.colorScheme.palette.base05}b3";
  base05-normal = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}b3";
  base0D = "#${config.colorScheme.palette.base0D}";
  playSound = pkgs.writeShellScript "play-sound" ''
    SOUND_NAME="$1"
    VOLUME_FILE="$HOME/.cache/${hosts.username}/notify-volume"
    CURRENT_VOLUME="''${2:-$(cat "$VOLUME_FILE")}"

    paplay "$HOME/.config/assets/sounds/''${SOUND_NAME}.mp3" --volume="$CURRENT_VOLUME"
  '';
in {
  imports = mylib.autoimport ./.;

  services.mako = {
    enable = homes.mako;
    settings = {
      anchor = "top-right";
      background-color = base01;
      border-radius = 8;
      border-size = 2;
      font = "${homes.nerdfont} Nerd Font";
      format = "<span font=\"14\" foreground=\"${base07}\"><b>%s</b></span>\\n<span font=\"12\" foreground=\"${base05-normal}\">%b</span>";
      height = 300;
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
      icons = true;
      layer = "overlay";
      margin = 8;
      max-history = 20;
      max-icon-size = 64;
      max-visible = 5;
      on-button-left = "invoke-default-action";
      on-button-right = "dismiss";
      padding = 8;
      progress-color = "over ${base0D}";
      sort = "-time";
      width = 400;
    };

    extraConfig = ''
      [mode=dnd]
      invisible=1

      [urgency=low]
      background-color=${base01}
      border-color=${base05}
      default-timeout=1000
      on-notify=exec ${playSound} Chord

      [urgency=normal]
      background-color=${base01}
      border-color=${base00}
      default-timeout=3000
      on-notify=exec ${playSound} Chord

      [urgency=high]
      background-color=${base01}
      border-color=${base08}
      default-timeout=4000
      on-notify=exec ${playSound} Sonar

      [app-name=Firefox]
      urgency=normal
      on-notify=exec ${playSound} camera-shutter

      [app-name=screenshot]
      on-notify=exec ${playSound} camera-shutter

      [app-name=screenrecord]
      on-notify=exec sh -c "sleep 2 && ${playSound} clapper-board"

      [app-name=game_on]
      on-notify=exec ${playSound} Mario-power-up 32768

      [app-name=game_off]
      on-notify=exec ${playSound} Mario-power-down 32768

      [app-name=playerctl]
      on-notify=exec ${playSound} Hello

      [category=e]
      history=0
    '';
  };
}
