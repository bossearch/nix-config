{
  hosts,
  pkgs,
  ...
}: {
  services.gnome.gnome-keyring.enable = hosts.gui.enable;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage =
      if hosts.gui.enable
      then pkgs.pinentry-qt
      else pkgs.pinentry-tty;
  };
}
