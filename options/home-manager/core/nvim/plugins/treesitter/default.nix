{config, ...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        bash
        c
        c_sharp
        cairo
        cmake
        cpp
        css
        diff
        fish
        git_config
        git_rebase
        gitattributes
        gitcommit
        gitignore
        glsl
        html
        java
        javascript
        json
        kotlin
        lua
        make
        markdown
        nix
        python
        regex
        tmux
        toml
        udev
        vim
        vimdoc
        xml
        yaml
        zsh
      ];
      highlight.enable = true;
      indent.enable = true;
      # folding.enable = true;
      lazyLoad = {
        settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        enable = false;
      };
    };
    treesitter-textobjects = {
      enable = false;
      settings = {
        select.enable = false;
        move = {
          enable = true;
          setJumps = true;
          goto_next_start.__raw = ''
            {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            }
          '';
          goto_next_end.__raw = ''
            {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            }
          '';
          goto_previous_start.__raw = ''
            {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            }
          '';
          goto_previous_end.__raw = ''
            {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            }
          '';
        };
      };
    };
    ts-autotag = {
      enable = true;
      lazyLoad = {
        settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
    };
    ts-comments = {
      enable = true;
      lazyLoad = {
        settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
    };
  };
}
