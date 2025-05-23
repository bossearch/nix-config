{pkgs, ...}: {
  imports = [./tokyonight.nix];
  programs.btop = {
    enable = true;
    package = pkgs.btop-rocm;
    settings = {
      color_theme = "/home/bosse/.config/btop/themes/tokyonight.theme";
      vim_keys = true;
      shown_boxes = "cpu mem net proc gpu0";
      proc_sorting = "memory";
      mem_graphs = false;
      swap_disk = false;
      custom_gpu_name0 = "RX 6600 XT";
    };
  };
}
