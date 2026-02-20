{
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.game.lsfg (with pkgs; [
    lsfg-vk
    vulkan-tools
  ]);
  home.file.".config/lsfg-vk/conf.toml" = lib.mkIf homes.game.lsfg {
    text = ''
      version = 1

      [global]
      dll = "/home/${hosts.username}/.local/share/Steam/steamapps/common/Lossless Scaling/Lossless.dll"
      # [[game]]
      # exe = "BloodStrike.exe"
      # multiplier = 3
      # flow_scale = 1.0
      # performance_mode = false
      # hdr_mode = false
      # experimental_present_mode = "fifo"
    '';
  };
}
