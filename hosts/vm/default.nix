{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./../common/disks/btrfs-luks-impermanence.nix
    ./../common/core
    ./../common/optional/bluetooth.nix
    # ./../common/optional/bridge.nix
    ./../common/optional/font.nix
    # ./../common/optional/graphics.nix
    ./../common/optional/greetd.nix
    # ./../common/optional/hyprland.nix
    ./../common/optional/impermanence.nix
    ./../common/optional/luks-key.nix
    ./../common/optional/misc.nix
    ./../common/optional/nix-ld.nix
    ./../common/optional/pipewire.nix
    ./../common/optional/silent-boot.nix
    # ./../common/optional/steam.nix
    ./../common/optional/udev.nix
    ./../common/optional/usbguard.nix
    # ./../common/optional/virt-manager.nix
    # ./../common/optional/waydroid.nix
  ];

  port = {
    TCPPorts = [80 443];
  };

  spec = {
    hostName = "vm";
    userName = "bosse";
    timeZone = "Asia/Singapore";
    theme = "tokyo-night-dark";
    disk = "/dev/vda";
    swap = false;
    swapSize = "0G";
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
