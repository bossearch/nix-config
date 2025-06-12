{config, ...}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base03 = "#${config.colorScheme.palette.base03}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  home.file.".config/btop/themes/base16.theme" = {
    text = ''
      # Main bg
      theme[main_bg]=${base00}

      # Main text color
      theme[main_fg]=${base07}

      # Title color for boxes
      theme[title]=${base07}

      # Highlight color for keyboard shortcuts
      theme[hi_fg]=${base0C}

      # Background color of selected item in processes box
      theme[selected_bg]=${base03}

      # Foreground color of selected item in processes box
      theme[selected_fg]=${base07}

      # Color of inactive/disabled text
      theme[inactive_fg]=${base03}

      # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
      theme[proc_misc]=${base0C}

      # Cpu box outline color
      theme[cpu_box]=${base0F}

      # Memory/disks box outline color
      theme[mem_box]=${base0F}

      # Net up/down box outline color
      theme[net_box]=${base0F}

      # Processes box outline color
      theme[proc_box]=${base0F}

      # Box divider line and small boxes line color
      theme[div_line]=${base0F}

      # Temperature graph colors
      theme[temp_start]=${base0B}
      theme[temp_mid]=${base0A}
      theme[temp_end]=${base08}

      # CPU graph colors
      theme[cpu_start]=${base0B}
      theme[cpu_mid]=${base0A}
      theme[cpu_end]=${base08}

      # Mem/Disk free meter
      theme[free_start]=${base0B}
      theme[free_mid]=${base0A}
      theme[free_end]=${base08}

      # Mem/Disk cached meter
      theme[cached_start]=${base0B}
      theme[cached_mid]=${base0A}
      theme[cached_end]=${base08}

      # Mem/Disk available meter
      theme[available_start]=${base0B}
      theme[available_mid]=${base0A}
      theme[available_end]=${base08}

      # Mem/Disk used meter
      theme[used_start]=${base0B}
      theme[used_mid]=${base0A}
      theme[used_end]=${base08}

      # Download graph colors
      theme[download_start]=${base0B}
      theme[download_mid]=${base0A}
      theme[download_end]=${base08}

      # Upload graph colors
      theme[upload_start]=${base0B}
      theme[upload_mid]=${base0A}
      theme[upload_end]=${base08}
    '';
  };
}
