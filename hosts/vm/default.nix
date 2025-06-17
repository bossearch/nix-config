{
  config,
  outputs,
  ...
}: {
  imports =
    [
      ./disko.nix
      ./hardware-configuration.nix
      # ./../common/core
      ./../common/core/firewall.nix
      ./../common/core/sops.nix
      ./../common/core/ssh.nix
      # ./../common/optional/bluetooth.nix
      # ./../common/optional/font.nix
      # ./../common/optional/graphics.nix
      # ./../common/optional/greetd.nix
      # ./../common/optional/hyprland.nix
      # ./../common/optional/misc.nix
      # ./../common/optional/nix-ld.nix
      # ./../common/optional/pipewire.nix
      # ./../common/optional/silent-boot.nix
      # ./../common/optional/steam.nix
      # ./../common/optional/udev.nix
      # ./../common/optional/usbguard.nix
      # ./../common/optional/virt-manager.nix
      # ./../common/optional/waydroid.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  port = {
    TCPPorts = [80 443];
  };

  spec = {
    hostName = "vm";
    userName = "bosse";
    timeZone = "Asia/Singapore";
    theme = "tokyo-night-dark";
  };

  # re declare this on main hosts file for testing
  networking = {
    hostName = "${config.spec.hostName}";
    networkmanager.enable = true;
  };
  time.timeZone = "${config.spec.timeZone}";
  users.users.${config.spec.userName} = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video"];
  };
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 1;
  };
  #

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
