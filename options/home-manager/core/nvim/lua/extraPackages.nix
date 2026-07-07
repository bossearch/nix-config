{pkgs, ...}: let
  markdown-toc = pkgs.buildNpmPackage {
    name = "markdown-toc";
    version = "1.2.0";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/markdown-toc/-/markdown-toc-1.2.0.tgz";
      sha256 = "sha256-Slvz76+yEheImrJAyqzXlaEQG/vgfNirsijMRJN6zZw=";
    };
    postPatch = ''
      cp ${../package-lock.json} ./package-lock.json
    '';
    npmDepsHash = "sha256-ZuR3zPaOM4CkuzBin9F3lj1qeD1w42g6NwSMQFambI4=";
    dontNpmBuild = true;
    meta.mainProgram = "markdown-toc";
  };
in {
  programs.neovim = {
    extraPackages = with pkgs; [
      # needed by plugins
      gcc
      gnumake
      tree-sitter
      lsof
      # lua
      lua-language-server
      stylua
      luaPackages.luacheck
      # c & cpp
      clang-tools
      # nix
      nixd
      alejandra
      # bash
      bash-language-server
      shfmt
      shellcheck
      # md
      marksman
      markdown-toc
      markdownlint-cli2
      prettier
      # fish
      fish-lsp
      # kotlin
      kotlin-language-server
      ktlint
      # qml
      kdePackages.qtdeclarative
      # html/css/json/eslint
      vscode-langservers-extracted-latest
      htmlhint
      stylelint
    ];
    extraWrapperArgs = [
      "--set"
      "CODELLDB_PATH"
      "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"
    ];
  };
}
