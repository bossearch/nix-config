{
  time.timeZone = "Asia/Singapore";

  services.openssh.enable = true;

  users.users.bosse = {
    # temporary will got replaced after full build
    initialPassword = "bosse";
    isNormalUser = true;
  };

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
