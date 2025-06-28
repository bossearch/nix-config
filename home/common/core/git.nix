{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
  ];

  programs.git = {
    enable = true;
    userName = "bossearch";
    userEmail = "yudha.bosse@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
