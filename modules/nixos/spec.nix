{
  config,
  lib,
  ...
}: let
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
        timeZone = mkOption {
          default = lib.mkDefault "Asia/Singapore";
          type = types.str;
        };
        theme = mkOption {
          default = lib.mkDefault "tokyo-night-dark";
          type = lib.types.enum [
            "catppuccin-mocha"
            "tokyo-night-dark"
          ];
        };
        disk = mkOption {
          default = "/dev/vda";
          type = types.str;
        };
        swap = mkOption {
          default = false;
          type = types.bool;
        };
        swapSize = mkOption {
          default = "";
          type = types.str;
        };
      };
    };
  };
  config = {
    assertions = [
      {
        assertion = !(config.spec.swap) || (config.spec.swapSize != "");
        message = "If `spec.swap` is true, then `spec.swapSize` must be specified.";
      }
    ];
  };
}
