{
  config,
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      nixd = {
        enable = true;
        settings = let
          host = config.spec.hostName;
          user = config.spec.userName;
          flake = ''(builtins.getFlake "github:bossearch/nix-config")'';
        in {
          nixpkgs.expr = "import <nixpkgs> {}";
          options = {
            nixos.expr = ''${flake}.nixosConfigurations.${host}.options'';
            home_manager.expr = ''${flake}.homeConfigurations."${user}@${host}".options'';
          };
        };
      };
    };
  };

  conform = {
    formatters_by_ft = {
      nix = ["alejandra"];
    };
    formatters = {
      alejandra = {
        command = lib.getExe pkgs.alejandra;
      };
    };
  };

  lint = {
    lintersByFt = {
      nix = ["nix"];
    };
  };
}
