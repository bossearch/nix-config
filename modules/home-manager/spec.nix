# TODO: add font type options
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.spec = mkOption {
    type = types.submodule {
      options = {
        hostName = mkOption {
          default = lib.mkDefault "pc";
          type = types.str;
        };
        userName = mkOption {
          default = lib.mkDefault "bosse";
          type = types.str;
        };
        theme = mkOption {
          default = lib.mkDefault "tokyo-night-dark";
          type = lib.types.enum [
            "catppuccin-mocha"
            "tokyo-night-dark"
          ];
        };
      };
    };
  };
}
