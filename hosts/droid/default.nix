{
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: let
  theme = "tokyo-night-dark";
  inherit (inputs.nix-colors.lib) schemeFromYAML;
  colorScheme =
    schemeFromYAML
    theme
    (builtins.readFile ../../modules/themes/${theme}.yaml);
in {
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    busybox
    git
    hostname
    man
    openssh
    procps
    socat
    sshpass
    ssh-to-age
    vim
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Fix for private dns
  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver 1.1.1.1
    nameserver 2606:4700:4700::1111
  '';

  # Android/Termux specific configuration
  android-integration = {
    termux-open.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };

  # Home manager configuration
  home-manager.config = ../../home/droid;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  user.shell = "${pkgs.fish}/bin/fish";

  terminal = {
    font = "${pkgs.nerd-fonts.commit-mono}/share/fonts/opentype/NerdFonts/CommitMono/CommitMonoNerdFont-Regular.otf";

    # Dracula colorscheme
    colors = {
      background = "#${colorScheme.palette.base00}";
      foreground = "#${colorScheme.palette.base07}";

      cursor = "#${colorScheme.palette.base07}";
      color0 = "#${colorScheme.palette.base01}";
      color1 = "#${colorScheme.palette.base08}";
      color2 = "#${colorScheme.palette.base0B}";
      color3 = "#${colorScheme.palette.base0A}";
      color4 = "#${colorScheme.palette.base0D}";
      color5 = "#${colorScheme.palette.base0E}";
      color6 = "#${colorScheme.palette.base0C}";
      color7 = "#${colorScheme.palette.base05}";

      color8 = "#${colorScheme.palette.base03}";
      color9 = "#${colorScheme.palette.base08}";
      color10 = "#${colorScheme.palette.base0B}";
      color11 = "#${colorScheme.palette.base0A}";
      color12 = "#${colorScheme.palette.base0D}";
      color13 = "#${colorScheme.palette.base0E}";
      color14 = "#${colorScheme.palette.base0C}";
      color15 = "#${colorScheme.palette.base07}";
    };
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
