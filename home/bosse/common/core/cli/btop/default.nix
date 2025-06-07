{
  config,
  pkgs,
  ...
}: let
  boxes =
    if config.spec.hostName == "pc"
    then "cpu proc gpu0"
    else "cpu proc";
in {
  imports = [./tokyonight.nix];
  programs.btop = {
    enable = true;
    package = pkgs.btop-rocm;
    settings = {
      color_theme = "/home/bosse/.config/btop/themes/tokyonight.theme";
      custom_gpu_name0 = "RX 6600 XT";
      proc_cpu_graphs = false;
      proc_gradient = false;
      proc_sorting = "memory";
      shown_boxes = boxes;
      vim_keys = true;
    };
  };
}
