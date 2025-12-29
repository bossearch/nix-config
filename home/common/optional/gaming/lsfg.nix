{pkgs, ...}: {
  home.packages = with pkgs; [
    lsfg-vk
    # lsfg-vk-ui
    vulkan-tools
  ];
  home.file.".config/lsfg-vk/conf.toml".text = ''
    version = 1

    [global]
    dll = "/home/bosse/.local/share/Steam/steamapps/common/Lossless Scaling/Lossless.dll"
    # [[game]]
    # exe = "BloodStrike.exe"
    # multiplier = 3
    # flow_scale = 1.0
    # performance_mode = false
    # hdr_mode = false
    # experimental_present_mode = "fifo"
  '';
}
