{inputs, ...}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = ../../../../../modules/themes/tokyo-night-dark.yaml;
    targets = {
      kitty = {
        enable = true;
        variant256Colors = true;
      };
      nixvim = {
        enable = true;
        plugin = "mini.base16";
        transparentBackground = {
          main = false;
          numberLine = false;
          signColumn = false;
        };
      };
    };
  };
}
