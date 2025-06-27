{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence = {
    "/persist" = {
      directories =
        [
          {
            directory = "/etc/NetworkManager/system-connections";
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = "/etc/ssh";
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = "/var/lib/bluetooth";
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = "/var/lib/systemd";
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = "/var/lib/nixos";
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = "/var/log";
            user = "root";
            group = "root";
            mode = "0755";
          }
        ]
        ++ lib.optionals config.virtualisation.libvirtd.enable (
          [
            {
              directory = "/var/lib/libvirt";
              user = "root";
              group = "root";
              mode = "0755";
            }
          ]
          ++ lib.optionals config.virtualisation.libvirtd.qemu.swtpm.enable [
            {
              directory = "/var/lib/swtpm-localca";
              user = "root";
              group = "root";
              mode = "0750";
            }
          ]
          ++ lib.optionals config.virtualisation.libvirtd.qemu.ovmf.enable [
            {
              directory = "/var/lib/tpm";
              user = "root";
              group = "root";
              mode = "0700";
            }
          ]
        )
        ++ lib.optionals config.virtualisation.waydroid.enable [
          {
            directory = "/var/lib/waydroid";
            user = "root";
            group = "root";
            mode = "0755";
          }
        ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
