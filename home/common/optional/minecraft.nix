{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
    # temurin-jre-bin
  ];
}
