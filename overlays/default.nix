{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.stdenv.hostPlatform.system} or {};
          packages = (flake.packages or {}).${final.stdenv.hostPlatform.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  stable = final: _: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      vimPlugins = (prev.vimPlugins or {}) // import ../pkgs/nvim-plugins {pkgs = final;};
    };

  modifications = final: prev: {
    # waybar = addPatches prev.waybar [
    #   ./waybar-hyprland-window.diff
    # ];
    vimPlugins =
      prev.vimPlugins
      // {
        lualine-nvim = addPatches prev.vimPlugins.lualine-nvim [
          ./lualine-16color.diff
        ];
        mini-base16 = addPatches prev.vimPlugins.mini-base16 [
          ./mini-base16.diff
        ];
      };
  };
}
