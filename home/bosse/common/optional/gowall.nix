{
  config,
  lib,
  pkgs,
  ...
}: let
  Gowall_dir = "${config.home.homeDirectory}/Pictures/gowall";
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base02 = "${config.lib.stylix.colors.withHashtag.base02}";
  base03 = "${config.lib.stylix.colors.withHashtag.base03}";
  base04 = "${config.lib.stylix.colors.withHashtag.base04}";
  base05 = "${config.lib.stylix.colors.withHashtag.base05}";
  base06 = "${config.lib.stylix.colors.withHashtag.base06}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
  base09 = "${config.lib.stylix.colors.withHashtag.base09}";
  base0A = "${config.lib.stylix.colors.withHashtag.base0A}";
  base0B = "${config.lib.stylix.colors.withHashtag.base0B}";
  base0C = "${config.lib.stylix.colors.withHashtag.base0C}";
  base0D = "${config.lib.stylix.colors.withHashtag.base0D}";
  base0E = "${config.lib.stylix.colors.withHashtag.base0E}";
  base0F = "${config.lib.stylix.colors.withHashtag.base0F}";
in {
  home.activation.gowalldir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Gowall_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Gowall_dir}
    fi
  '';
  home.file.".config/gowall/config.yml".text = ''
    EnableImagePreviewing: false
    InlineImagePreview: false
    themes:
      - name: "palette"
        colors:
          - "${base00}"
          - "${base01}"
          - "${base02}"
          - "${base03}"
          - "${base04}"
          - "${base05}"
          - "${base06}"
          - "${base07}"
          - "${base08}"
          - "${base09}"
          - "${base0A}"
          - "${base0B}"
          - "${base0C}"
          - "${base0D}"
          - "${base0E}"
          - "${base0F}"
  '';
}
