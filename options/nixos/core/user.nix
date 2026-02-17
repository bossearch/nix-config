{
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  passwordFile =
    if config.spec.sops
    then config.sops.secrets.passwd.path
    else ../../${config.spec.hostname}/user_password_hash;
in {
  # Define a user account.
  sops.secrets.passwd.neededForUsers = lib.mkIf config.spec.sops true;

  users = {
    mutableUsers = false;
    users.${config.spec.username} = {
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
        ../../../hosts/${config.spec.hostname}/id_${config.spec.hostname}.pub
      ];
      hashedPasswordFile = passwordFile;
    };
  };
}
