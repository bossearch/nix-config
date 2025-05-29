# TODO: add font type options
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.spec = mkOption {
    type = types.submodule {
      options = {
        hostName = mkOption {
          type = types.str;
          example = "pc";
        };
        userName = mkOption {
          type = types.str;
          example = "bosse";
        };
      };
    };
  };
}
