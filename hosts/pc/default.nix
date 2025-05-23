{...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/core
    ./../common/optional/bluetooth.nix
    ./../common/optional/font.nix
    ./../common/optional/graphics.nix
    ./../common/optional/greetd.nix
    ./../common/optional/hyprland.nix
    ./../common/optional/misc.nix
    ./../common/optional/nix-ld.nix
    ./../common/optional/pipewire.nix
    ./../common/optional/silent-boot.nix
    ./../common/optional/steam.nix
    ./../common/optional/udev.nix
    ./../common/optional/usbguard.nix
    ./../common/optional/virt-manager.nix
    ./../common/optional/waydroid.nix
  ];

  port = {
    TCPPorts = [80 443 53317];
    TCPPortsRanges = [{ from = 1714; to = 1764; }];
    UDPPortsRanges = [{ from = 1714; to = 1764; }];
  };

  networking = {
    hostName = "pc";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bosse = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "libvirtd"];
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
