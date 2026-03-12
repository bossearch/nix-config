{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
  ];

  programs.git = {
    enable = true;
    package = pkgs.git.override {withLibsecret = true;};
    settings = {
      user = {
        name = "bossearch";
        email = "yudha.bosse@gmail.com";
      };
      credential.helper = "libsecret";
    };
  };
}
