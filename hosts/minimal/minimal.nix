{pkgs, ...}: {
  time.timeZone = "Asia/Singapore";

  users.users.bosse = {
    # temporary will got replaced after full build
    initialPassword = "bosse";
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

  environment.systemPackages = with pkgs; [gitMinimal];
  # bootstrap full nixos config from TTY autologin using bash loginShellInit
  programs.bash = {
    loginShellInit = ''
      if [ ! -d "$HOME/.nix-config" ]; then
        echo "[+] Cloning and installing full config..."
        git clone --branch bootstrap https://github.com/bossearch/nix-config "$HOME/.nix-config"
        exec "$HOME/.nix-config/scripts/install.sh"
      fi
    '';
  };

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
