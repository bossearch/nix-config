{
  config,
  hosts,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  passwordFile =
    if hosts.sops
    then config.sops.secrets.passwd.path
    else ../../${hosts.hostname}/user_password_hash;
in {
  # Define a user account.
  sops.secrets.passwd.neededForUsers = lib.mkIf hosts.sops true;

  users = {
    mutableUsers = false;
    users.${hosts.username} = {
      isNormalUser = true;
      extraGroups = lib.flatten [
        "wheel"
        (ifTheyExist [
          "audio"
          "video"
          "docker"
          "git"
          "networkmanager"
          "libvirtd"
          "scanner" # for print/scan"
          "lp" # for print/scan"
          "i2c"
        ])
      ];
      openssh.authorizedKeys.keyFiles = [
        ../../../hosts/${hosts.hostname}/id_${hosts.hostname}.pub
      ];
      hashedPasswordFile = passwordFile;
    };
  };
}
