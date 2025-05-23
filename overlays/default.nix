{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        name: flake:
          if name == "firefox-addons"
          then
            import inputs.firefox-addons {
              fetchurl = final.fetchurl;
              lib = final.lib;
              stdenv = final.stdenv;
            }
          else let
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
    unstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      vimPlugins = (prev.vimPlugins or {}) // import ../pkgs/nvim-plugins {pkgs = final;};
    };

  modifications = final: prev: {
    vimPlugins =
      prev.vimPlugins
      // {
        nui-nvim = addPatches prev.vimPlugins.nui-nvim [
          # ./nui-nvim-tbl-islist.diff
        ];
      };
  };
}
