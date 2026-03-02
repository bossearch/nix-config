{
  hosts,
  lib,
  pkgs,
  ...
}: {
  home = lib.mkIf hosts.udevqmk {
    packages = with pkgs; [
      (python312.withPackages (ps: with ps; [hidapi]))
    ];

    file.".config/qmk/crkbd-toggle-game.py" = {
      executable = true;
      text = ''
        #!/usr/bin/env python3
        import hid
        import sys

        VID = 0x4653
        PID = 0x0001
        RAW_USAGE_PAGE = 0xFF60
        RAW_USAGE_ID = 0x61

        def send_layer(layer_code):
            h = hid.device()
            target_path = None

            for device_info in hid.enumerate(VID, PID):
                if device_info['usage_page'] == RAW_USAGE_PAGE:
                    target_path = device_info['path']
                    break

            if not target_path:
                for device_info in hid.enumerate(VID, PID):
                    if device_info['interface_number'] == 1:
                        target_path = device_info['path']
                        break

            if target_path:
                try:
                    h.open_path(target_path)
                    buf = [0] * 33
                    buf[1] = layer_code
                    h.write(buf)
                    h.close()
                    print(f"Success: Layer {layer_code} sent to {target_path}")
                except Exception as e:
                    print(f"Error opening device: {e}")
            else:
                print("Raw HID interface not found.")

        if __name__ == "__main__":
            if len(sys.argv) > 1:
                send_layer(int(sys.argv[1]))
      '';
    };
  };
}
