{
  config,
  hosts,
  inputs,
  lib,
  ...
}: let
  impermanence = lib.elem hosts.disko.type [
    "btrfs-luks-impermanence"
    "btrfs-impermanence"
  ];
in {
  imports = [inputs.impermanence.nixosModules.impermanence];
  config = lib.mkIf impermanence {
    environment.persistence = {
      "/persist" = {
        hideMounts = true;
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
        users.${hosts.username}.directories = ["."];
      };
    };
    system.activationScripts.persistent-dirs.text = (
      let
        mkHomePersist = user:
          lib.optionalString user.createHome ''
            mkdir -p /persist/${user.home}
            chown ${user.name}:${user.group} /persist/${user.home}
            chmod ${user.homeMode} /persist/${user.home}
          '';
        users = lib.attrValues config.users.users;
      in
        lib.concatLines (map mkHomePersist users)
    );
  };
}
