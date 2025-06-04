{pkgs}: {
  colorful-winsep = pkgs.callPackage ./colorful-winsep.nix {};
  nvim-pqf = pkgs.callPackage ./nvim-pqf.nix {};
}
