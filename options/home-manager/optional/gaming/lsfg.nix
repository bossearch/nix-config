{
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.game.lsfg (with pkgs; [
    lsfg-vk
    lsfg-vk-ui
  ]);
  home.file.".config/lsfg-vk/conf.toml" = lib.mkIf homes.game.lsfg {
    text = ''
      version = 1
      LSFG_PROCESS="java"

      [global]
      dll = "/home/${hosts.username}/.local/share/Steam/steamapps/common/Lossless Scaling/Lossless.dll"

      # [[game]]
      # exe = "java"
      # multiplier = 2
      # flow_scale = 1.0
      # performance_mode = false
      # hdr_mode = false
      # experimental_present_mode = "fifo"

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
