{lib}: let
  autoimportSet = import ./autoimport.nix {inherit lib;};
in {
  inherit (autoimportSet) autoimport;
}
