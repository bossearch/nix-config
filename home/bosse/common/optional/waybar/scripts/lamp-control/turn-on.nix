{
  home.file.".config/waybar/scripts/lamp-control/turn-on.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # IP address of the lamp
      lamp_ip="192.168.18.14"
      port=38899

      # Turn off the lamp by setting dimming to 0
      # echo -n "{\"id\":1,\"method\":\"setState\",\"params\":{\"state\":true}}" | socat -u -w 1 $lamp_ip $port
      echo -n "{\"id\":1,\"method\":\"setState\",\"params\":{\"state\":true}}" | socat - UDP:$lamp_ip:$port

      pkill -SIGRTMIN+15 waybar
    '';
  };
}
