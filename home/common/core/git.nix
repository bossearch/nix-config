{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "bossearch";
        email = "yudha.bosse@gmail.com";
      };
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
