{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        path = "/tmp/hyprlock.png";
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
          outer_color = "rgba(16161ECC)";
          inner_color = "rgba(1A1B26CC)";
          check_color = "rgb(16161E)";
          fail_color = "rgb(F7768E)";
          font_color = "rgb(C0CAF5)";
          font_family = "CommitMono Nerd Font";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##C0CAF5\"><i>󰌾 Logged in as </i><span foreground=\"##7DCFFF\">$USER</span></span>";
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
          color = "rgb(C0CAF5)";
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
          color = "rgb(C0CAF5)";
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
