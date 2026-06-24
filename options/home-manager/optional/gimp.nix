{
  homes,
  lib,
  pkgs,
  ...
}: {
  home = lib.mkIf homes.gimp {
    packages = with pkgs; [
      gimp-with-plugins
    ];
    file.".config/GIMP/3.0/plug-ins/gimp-dds-plugin" = {
      source = pkgs.fetchFromGitHub {
        owner = "gyoerkaa";
        repo = "gimp-dds-plugin";
        rev = "0d6422d9efedc3727ea16a8281fd3cb469a6d839";
        sha256 = "sha256-8jJHdR/hMCcYOxYMdU9/Ms+qsHxsnnDlwdnR8XCt0xA=";
      };
    };
    file.".config/GIMP/3.0/controllerrc" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/loloolooo/photoshop-keymap-for-gimp/refs/heads/3.x/controllerrc";
        sha256 = "sha256-EuIKudCzGcYCkT3kIG/Z+aUnV0Gk8cV30ZQ7JJAiUK8=";
      };
      force = true;
    };
    file.".config/GIMP/3.0/shortcutsrc" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/loloolooo/photoshop-keymap-for-gimp/refs/heads/3.x/shortcutsrc";
        sha256 = "sha256-yAa4ZOP8iSKIm6OPFRS7yr86r1WLvRcx9k0GGyNKVIE=";
      };
      force = true;
    };
  };
}
