{config, ...}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base03 = "#${config.colorScheme.palette.base03}";
  base04 = "#${config.colorScheme.palette.base04}";
  base05 = "#${config.colorScheme.palette.base05}";
  base06 = "#${config.colorScheme.palette.base06}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0E = "#${config.colorScheme.palette.base0E}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  programs.yazi.theme = {
    mgr = {
      cwd = {
        fg = base05;
        italic = true;
      };

      # Hovered
      hovered = {bg = base03;};
      preview_hovered = {bg = base03;};

      # Find
      find_keyword = {
        fg = base01;
        bg = base09;
        bold = true;
      };
      find_position = {
        fg = base0F;
        bg = base06;
        bold = true;
      };

      # Marker
      marker_copied = {
        fg = base0B;
        bg = base0B;
      };
      marker_cut = {
        fg = base08;
        bg = base08;
      };
      marker_marked = {
        fg = base0E;
        bg = base0E;
      };
      marker_selected = {
        fg = base0D;
        bg = base0D;
      };

      # Count
      count_copied = {
        fg = base07;
        bg = base0B;
      };
      count_cut = {
        fg = base07;
        bg = base08;
      };
      count_selected = {
        fg = base07;
        bg = base0D;
      };

      # Border
      border_symbol = "│";
      border_style = {fg = base0F;};
    };

    tabs = {
      active = {
        fg = base07;
        bg = base02;
      };
      inactive = {
        fg = base02;
        bg = base00;
      };
    };

    status = {
      separator_open = "";
      separator_close = "";
      separator_style = {
        fg = base02;
        bg = base02;
      };

      # Mode
      mode_normal = {
        fg = base01;
        bg = base0D;
        bold = true;
      };
      mode_select = {
        fg = base01;
        bg = base0E;
        bold = true;
      };
      mode_unset = {
        fg = base01;
        bg = base0E;
        bold = true;
      };

      # Progress
      progress_label = {
        fg = base05;
        bold = true;
      };
      progress_normal = {fg = base00;};
      progress_error = {fg = base08;};

      # Permissions
      permissions_t = {fg = base0D;};
      permissions_r = {fg = base0A;};
      permissions_w = {fg = base08;};
      permissions_x = {fg = base0B;};
      permissions_s = {fg = base03;};
    };

    select = {
      border = {fg = base0F;};
      active = {
        fg = base07;
        bg = base02;
      };
      inactive = {fg = base07;};
    };

    input = {
      border = {fg = base0F;};
      title = {};
      value = {fg = base0E;};
      selected = {bg = base02;};
    };

    completion = {
      border = {fg = base0F;};
      active = {
        fg = base07;
        bg = base02;
      };
      inactive = {fg = base07;};
    };

    tasks = {
      border = {fg = base0F;};
      title = {};
      hovered = {
        fg = base07;
        bg = base02;
      };
    };

    which = {
      cols = 3;
      mask = {bg = base01;};
      cand = {fg = base0C;};
      rest = {fg = base0D;};
      desc = {fg = base0E;};
      separator = "  ";
      separator_style = {fg = base04;};
    };

    notify = {
      title_info = {fg = base0F;};
      title_warn = {fg = base0A;};
      title_error = {fg = base08;};
    };

    help = {
      on = {fg = base0B;};
      run = {fg = base0E;};
      hovered = {bg = base02;};
      footer = {
        fg = base07;
        bg = "#1a1b26";
      };
    };

    filetype = {
      rules = [
        # Images
        {
          mime = "image/*";
          fg = base0A;
        }

        # Media
        {
          mime = "{audio,video};/*";
          fg = base0E;
        }

        # Archives
        {
          mime = "application/*zip";
          fg = base08;
        }
        {
          mime = "application/x-{tar,bzip*,7z-compressed,xz,rar};";
          fg = base08;
        }

        # Documents
        {
          mime = "application/{pdf,doc,rtf,vnd.*};";
          fg = base0C;
        }

        # Empty files
        # { mime = "inode/x-empty"; fg = base08; };

        # Special files
        {
          name = "*";
          is = "orphan";
          bg = base08;
        }
        {
          name = "*";
          is = "exec";
          fg = base0B;
        }

        # Fallback
        {
          name = "*/";
          fg = base0D;
        }
      ];
    };
  };
}
