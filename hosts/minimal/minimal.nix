{
  time.timeZone = "Asia/Singapore";

  services.openssh.enable = true;

  users.users.root = {
    initialPassword = "root";
    isNormalUser = false;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
