{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ../../../../../modules/themes/tokyo-night-dark.yaml;
  };
}
