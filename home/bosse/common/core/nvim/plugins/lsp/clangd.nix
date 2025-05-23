{pkgs}: {
  enable = true;
  settings = {
    formatting.command = ["${pkgs.clang-tools}/bin/clang-format"];
  };
}
