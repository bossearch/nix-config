{
  config,
  hosts,
  mylib,
  pkgs,
  ...
}: let
  boxes =
    if hosts.hostname == "silvia"
    then "cpu proc gpu0"
    else "cpu proc";
in {
  imports = mylib.autoimport ./.;

  programs.btop = {
    enable = true;
    package = pkgs.btop-rocm;
    settings = {
      color_theme = "${config.home.homeDirectory}/.config/btop/themes/base16.theme";
      custom_gpu_name0 = "RX 6600 XT";
      proc_cpu_graphs = false;
      proc_gradient = false;
      proc_sorting = "memory";
      shown_boxes = boxes;
      vim_keys = true;
    };
  };
}
