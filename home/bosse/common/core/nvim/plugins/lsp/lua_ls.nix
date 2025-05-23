{
  lib,
  pkgs,
}: {
  enable = true;
  settings = {
    formatting.command = ["${lib.getExe pkgs.stylua}"];
  };
}
