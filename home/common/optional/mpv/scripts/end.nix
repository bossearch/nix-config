{config, ...}: {
  home.file.".config/mpv/scripts/end.lua" = {
    text = ''
      mp.add_key_binding("b", "end", function()
        -- Path to the bash script
        local script_path = "${config.home.homeDirectory}/.config/mpv/script-opts/end.sh"

        -- Execute the bash script
        local result = os.execute(script_path)
      end)
    '';
  };
}
