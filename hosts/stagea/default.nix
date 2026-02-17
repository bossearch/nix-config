{
  imports = [
    ../../options/nixos
    ./hardware-configuration.nix
  ];

  spec = {
    hostname = "stagea";
    username = "bosse";
    shell = "fish";
    locale = "en_US.UTF-8";
    timezone = "Asia/Singapore";
    theme = "tokyo-night-dark";
    disko = {
      type = "btrfs-impermanence";
      disk = "/dev/vda";
      swap = false;
      swapSize = "0G";
    };
    networking = {
      bridge = false;
      firewall = {
        enable = true;
        port = {
          TCPPorts = [80 443];
        };
      };
    };
    # optional
    bluetooth = false;
    displaymanager = true;
    dnscrypt = false;
    pipewire = true;
    proxychains = false;
    silentboot = true;
    sops = true;
    ssh = true;
    steam = false;
    udevqmk = false;
    usbguard = false;
    virtmanager = false;
    waydroid = false;
    windowmanager = "hyprland";
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
