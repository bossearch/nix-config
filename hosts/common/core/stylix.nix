{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ../../../modules/themes/tokyo-night-dark.yaml;
    targets = {
      console.enable = true;
    };
  };
}
