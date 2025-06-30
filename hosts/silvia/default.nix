{
  imports = [
    ./../common/core
    ./../common/users
    ./../common/disks
    ./../common/disks/btrfs-luks-impermanence.nix
    ./../common/optional/bluetooth.nix
    ./../common/optional/bridge.nix
    ./../common/optional/font.nix
    ./../common/optional/graphics.nix
    ./../common/optional/greetd.nix
    ./../common/optional/impermanence.nix
    ./../common/optional/luks-key.nix
    ./../common/optional/misc.nix
    ./../common/optional/nix-ld.nix
    ./../common/optional/pipewire.nix
    ./../common/optional/silent-boot.nix
    ./../common/optional/steam.nix
    ./../common/optional/udev.nix
    ./../common/optional/usbguard.nix
    ./../common/optional/virt-manager.nix
    ./../common/optional/waydroid.nix
    ./hardware-configuration.nix
  ];

  port = {
    TCPPorts = [80 443 53317];
    TCPPortsRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    UDPPortsRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  spec = {
    hostName = "silvia";
    userName = "bosse";
    timeZone = "Asia/Singapore";
    theme = "tokyo-night-dark";
    disk = "/dev/nvme0n1";
    swap = true;
    swapSize = "32G";
    impermanence = true;
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
