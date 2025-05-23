{
  config,
  lib,
  pkgs,
}: {
  enable = true;
  settings = let
    host = config.spec.hostName;
    user = config.spec.userName;
    flake = ''(builtins.getFlake "github:bossearch/.dotfiles)""'';
  in {
    formatting.command = ["${lib.getExe pkgs.alejandra}"];
    nixpkgs.expr = "import <nixpkgs> {}";
    options = {
      nixos.expr = ''${flake}.nixosConfigurations.${host}.options'';
      home_manager.expr = ''${flake}.homeConfigurations."${user}@${host}".options'';
    };
  };
}
