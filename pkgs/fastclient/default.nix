{pkgs ? import <nixpkgs> {}}:
pkgs.appimageTools.wrapType2 {
  pname = "fastclient";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://files.fastclient.net/releases/latest/linux-x86_64/FastClient.AppImage";
    hash = "sha256-9Dclc6gSO7T3Rp6pbIH+2Ablzx6fcKDKNULybjvk7NY=";
  };
}
