{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        path = "/home/${config.spec.userName}/.cache/${config.spec.userName}/hyprlock.png";
        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanat ions
        blur_size = 6;
        blur_passes = 3; # 0 disables blurring
        noise = 0.0117;
        contrast = 1.3000; # Vibrant!!!
        brightness = 0.8000;
        vibrancy = 0.2100;
        vibrancy_darkness = 0.0;
      };

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(${config.colorScheme.palette.base01}CC)";
          inner_color = "rgba(${config.colorScheme.palette.base00}CC)";
          check_color = "rgb(${config.colorScheme.palette.base01})";
          fail_color = "rgb(${config.colorScheme.palette.base08})";
          font_color = "rgb(${config.colorScheme.palette.base07})";
          font_family = "CommitMono Nerd Font";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##${config.colorScheme.palette.base07}\"><i>󰌾 Logged in as </i><span foreground=\"##${config.colorScheme.palette.base0C}\">$USER</span></span>";
          hide_input = false;
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          position = "0, 150";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # DATE
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %-d %B')\"";
          color = "rgb(${config.colorScheme.palette.base07})";
          font_size = 22;
          font_family = "Extra Bold";
          position = "0, 400";
          halign = "center";
          valign = "center";
        }
        # TIME
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(${config.colorScheme.palette.base07})";
          font_size = 95;
          font_family = "Extra Bold";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
