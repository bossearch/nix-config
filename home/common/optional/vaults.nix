{
  config,
  lib,
  pkgs,
  ...
}: let
  Vaults_dir = "${config.home.homeDirectory}/.local/share/Vaults/{Secrets,Lofi}";
in {
  home.packages = with pkgs; [
    gocryptfs
    vaults
  ];

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file://${config.home.homeDirectory}/.local/share/Vaults Vaults
  '';

  home.file.".config/user_config.toml" = {
    text = ''
      [Lofi]
      backend = "Gocryptfs"
      encrypted_data_directory = "${config.home.homeDirectory}/Downloads/.other"
      mount_directory = "${config.home.homeDirectory}/.local/share/Vaults/Lofi"
      session_lock = true

      [Secrets]
      backend = "Gocryptfs"
      encrypted_data_directory = "/media/External/Secrets"
      mount_directory = "${config.home.homeDirectory}/.local/share/Vaults/Secrets"
      session_lock = true
    '';
  };

  home.activation.vaultdir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Vaults_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Vaults_dir}
    fi
  '';
}
