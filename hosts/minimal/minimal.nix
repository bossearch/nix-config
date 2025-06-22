{
  users.users.bosse = {
    initialPassword = import ./password.nix;
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = "bosse";

  boot = {
    # Use systemd bootload
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 1;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
