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
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  unstable = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
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
    waybar = addPatches prev.waybar [
      ./waybar-hyprland-window.diff
    ];
    vimPlugins =
      prev.vimPlugins
      // {
        nui-nvim = addPatches prev.vimPlugins.nui-nvim [
          # ./nui-nvim-tbl-islist.diff
        ];
      };
  };
}
