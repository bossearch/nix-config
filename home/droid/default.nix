# {lib, ...}: let
#   inherit (lib) mkOption types;
# in {
#   imports = [
#     ../common/core/colors.nix
#     ../common/core/shell
#     ../common/core/cli/fastfetch
#     ../common/core/cli/fzf
#     ../common/core/cli/lazygit
#     ../common/core/cli/tealdeer
#     # ../common/core/cli/yazi
#   ];
#
#   programs.bat = {
#     enable = true;
#     config = {
#       pager = "less -FR";
#       theme = "ansi";
#     };
#   };
#   programs.zoxide = {
#     enable = true;
#     options = [
#       "--cmd cd"
#     ];
#   };
#
#   options.spec = mkOption {
#     type = types.submodule {
#       options = {
#         theme = mkOption {
#           default = lib.mkDefault "tokyo-night-dark";
#           type = lib.types.enum [
#             "catppuccin-mocha"
#             "tokyo-night-dark"
#           ];
#         };
#       };
#     };
#   };
#
#   config.spec.theme = "tokyo-night-dark";
#
#   # Do not change these future me !
#   home.stateVersion = "24.05"; # Please read the comment before changing.
# }
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ../common/core/colors.nix
    ../common/core/shell
    ../common/core/cli/fastfetch
    ../common/core/cli/fzf
    ../common/core/cli/lazygit
    ../common/core/cli/tealdeer
    # ../common/core/cli/yazi
  ];

  options.spec = mkOption {
    type = types.submodule {
      options = {
        theme = mkOption {
          default = lib.mkDefault "tokyo-night-dark";
          type = types.enum [
            "catppuccin-mocha"
            "tokyo-night-dark"
          ];
        };
      };
    };
  };

  config = {
    spec.theme = "tokyo-night-dark";

    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "ansi";
      };
    };

    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    # Do not change these future me !
    home.stateVersion = "24.05";
  };
}
