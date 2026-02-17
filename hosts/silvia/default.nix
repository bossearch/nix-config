{
  imports = [
    ../../options/nixos
    ./hardware-configuration.nix
  ];

  spec = {
    hostname = "silvia";
    username = "bosse";
    shell = "fish";
    locale = "en_US.UTF-8";
    timezone = "Asia/Singapore";
    theme = "tokyo-night-dark";
    disko = {
      type = "btrfs-luks-impermanence";
      disk = "/dev/nvme0n1";
      swap = "32G";
    };
    networking = {
      bridge = true;
      firewall = {
        enable = true;
        port = {
          TCPPorts = [80 443 6669 53317];
          TCPPortsRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          UDPPorts = [4242];
          UDPPortsRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
        };
      };
    };
    # optional
    bluetooth = true;
    displaymanager = true;
    dnscrypt = true;
    pipewire = true;
    proxychains = false;
    silentboot = true;
    sops = true;
    ssh = true;
    steam = true;
    udevqmk = true;
    usbguard = true;
    virtmanager = true;
    waydroid = false;
    windowmanager = "hyprland";
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
