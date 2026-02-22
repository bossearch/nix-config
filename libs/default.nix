{lib}: let
  autoimportSet = import ./autoimport.nix {inherit lib;};
  relativetorootSet = import ./relativetoroot.nix {inherit lib;};
in {
  inherit (autoimportSet) autoimport;
  at = relativetorootSet.relativetoroot;
}
