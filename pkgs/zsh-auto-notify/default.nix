# {pkgs, ...}:
# {
#   name = "zsh-auto-notify";
#   file = "auto-notify.plugin.zsh";
#   src = pkgs.fetchFromGitHub {
#     owner = "MichaelAquilina";
#     repo = "zsh-auto-notify";
#     rev = "cac2c193d9f227c99178ca7cf9e25152a36dd4ac";
#     sha256 = "sha256-8r5RsyldJIzlWr9+G8lrkHvJ8KxTVO859M//wDnYOUY=";
#   };
# }
{
  stdenv,
  fetchFromGitHub,
}:
# To make use of this derivation, use
# `programs.zsh.interactiveShellInit = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";`
stdenv.mkDerivation rec {
  pname = "zsh-auto-notify";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "MichaelAquilina";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "sha256-8r5RsyldJIzlWr9+G8lrkHvJ8KxTVO859M//wDnYOUY=";
  };

  strictDeps = true;
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/zsh-auto-notify
    cp auto-notify.plugin.zsh $out/share/zsh-auto-notify/zsh-auto-notify.plugin.zsh
  '';
}
