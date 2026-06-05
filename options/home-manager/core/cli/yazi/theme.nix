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
        bold = true;
        fg = base05;
        italic = true;
      };
      find_keyword = {
        fg = base00;
        bg = base09;
        bold = true;
      };
      find_position = {
        fg = base0C;
        bg = base01;
        bold = true;
      };
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
      count_copied = {
        fg = base02;
        bg = base0B;
      };
      count_cut = {
        fg = base02;
        bg = base08;
      };
      count_selected = {
        fg = base02;
        bg = base0D;
      };
      border_symbol = "│";
      border_style = {fg = base0F;};
    };

    indicator = {
      parent = {
        bg = base03;
      };
      current = {
        bg = base03;
      };
      preview = {};
      padding = {
        open = "█";
        close = "█";
      };
    };

    tabs = {
      active = {
        fg = base06;
        bg = base02;
        bold = true;
      };
      inactive = {
        fg = base02;
        bg = base01;
      };
    };

    status = {
      progress_label = {
        fg = base02;
        bold = true;
      };
      progress_normal = {
        fg = base0D;
        bg = base02;
      };
      progress_error = {
        fg = base08;
        bg = base02;
      };
      perm_type = {fg = base0D;};
      perm_read = {fg = base0A;};
      perm_write = {fg = base08;};
      perm_exec = {fg = base0B;};
      perm_sep = {fg = base03;};
    };

    which = {
      cols = 3;
      mask = {bg = base00;};
      cand = {fg = base0C;};
      rest = {fg = base0D;};
      desc = {fg = base0E;};
      separator = "  ";
      separator_style = {fg = base04;};
    };

    confirm = {
      border = {fg = base0F;};
      title = {fg = base0F;};
    };

    spot = {
      border = {fg = base0F;};
      title = {fg = base0F;};
      tbl_col = {fg = base0D;};
      tbl_cell = {
        fg = base0D;
        bg = base03;
      };
    };

    notify = {
      title_info = {fg = base0F;};
      title_warn = {fg = base0A;};
      title_error = {fg = base08;};
    };

    pick = {
      border = {fg = base0F;};
      active = {
        fg = base07;
        bg = base02;
      };
      inactive = {fg = base07;};
    };

    input = {
      border = {fg = base0F;};
      title = {fg = base0F;};
      value = {fg = base0E;};
      selected = {bg = base02;};
    };

    cmp = {
      border = {fg = base0F;};
      title = {fg = base0F;};
    };

    tasks = {
      border = {fg = base0F;};
      title = {fg = base0F;};
      hovered = {
        fg = base07;
        bg = base02;
      };
    };

    help = {
      on = {fg = base0B;};
      run = {fg = base0E;};
      hovered = {bg = base02;};
      footer = {
        fg = base07;
        bg = base01;
      };
    };

    filetype = {
      rules = [
        {
          url = "**/.nix-config/.*.log";
          fg = base04;
        }
        {
          url = "*/";
          fg = base0D;
        }
        {
          url = "*";
          is = "orphan";
          fg = "#DFDFDF";
          bg = base08;
        }
        {
          url = "**/*.{sh,py}";
          is = "link";
          fg = base0B;
          italic = true;
        }
        {
          url = "*";
          is = "link";
          fg = base07;
          italic = true;
        }
        {
          url = "*";
          is = "block";
          fg = base0C;
          bold = true;
        }
        {
          url = "*";
          is = "char";
          fg = base0C;
        }
        {
          url = "*";
          is = "fifo";
          fg = base09;
        }
        {
          url = "*";
          is = "sock";
          fg = base09;
        }
        {
          url = "*";
          is = "exec";
          fg = base0B;
        }
        {
          mime = "image/*";
          fg = base0A;
        }
        {
          mime = "{audio,video}/*";
          fg = base0E;
        }
        {
          mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
          fg = base08;
        }
        {
          mime = "inode/empty";
          fg = base04;
        }
      ];
    };

    icon = {
      dirs = [
        {
          name = ".config";
          text = "";
          fg = base0D;
        }
        {
          name = "Desktop";
          text = "";
          fg = base0D;
        }
        {
          name = "Devs";
          text = "";
          fg = base0D;
        }
        {
          name = "Documents";
          text = "";
          fg = base0D;
        }
        {
          name = "Downloads";
          text = "";
          fg = base0D;
        }
        {
          name = "Pictures";
          text = "";
          fg = base0D;
        }
        {
          name = "Videos";
          text = "";
          fg = base0D;
        }
      ];
      prepend_conds = [
        {
          "if" = "dir";
          text = "";
          fg = base0D;
        }
      ];
    };
  };
}
