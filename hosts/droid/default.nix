{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim
    git
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Android/Termux specific configuration
  android-integration = {
    # to make sure I have access to phone's storage system
    termux-open.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };

  # Home manager configuration
  home-manager.config = ../../home/droid;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Singapore";

  # Do not change these future me !
  system.stateVersion = "24.05"; # Please read the comment before changing.
}
