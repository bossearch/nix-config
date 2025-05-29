{
  lib,
  pkgs,
}: let
  markdown-toc = pkgs.buildNpmPackage {
    name = "markdown-toc";
    version = "1.2.0";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/markdown-toc/-/markdown-toc-1.2.0.tgz";
      sha256 = "sha256-Slvz76+yEheImrJAyqzXlaEQG/vgfNirsijMRJN6zZw=";
    };
    postPatch = ''
      cp ${./package-lock.json} ./package-lock.json
    '';
    npmDepsHash = "sha256-ZuR3zPaOM4CkuzBin9F3lj1qeD1w42g6NwSMQFambI4=";
    dontNpmBuild = true;
    meta.mainProgram = "markdown-toc";
  };
in {
  lsp = {
    servers = {
      marksman = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      markdown = ["prettier" "markdownlint-cli2" "markdown-toc"];
    };
    formatters = {
      prettier.command = lib.getExe pkgs.nodePackages.prettier;
      markdownlint-cli2 = {
        command = lib.getExe pkgs.markdownlint-cli2;
        condition.__raw = ''
          function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end
        '';
      };
      markdown-toc = {
        command = lib.getExe markdown-toc;
        condition.__raw = ''
          function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end
        '';
      };
    };
  };

  lint = {
    lintersByFt = {
      markdown = ["mdl"];
    };
    customLinters.mdl = {
      cmd = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
      ignore_exitcode = true;
      stream = "stderr";
      parser = ''
        require("lint.parser").from_errorformat(efm, {
          source = "markdownlint",
          severity = vim.diagnostic.severity.WARN,
        })'';
    };
  };
}
