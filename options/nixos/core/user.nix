{
  config,
  hosts,
  lib,
  mylib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  passwordFile =
    if hosts.sops
    then config.sops.secrets.passwd.path
    else mylib.at "hashedPasswordFile";
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
        (mylib.at "hosts/${hosts.hostname}/id_${hosts.hostname}.pub")
      ];
      hashedPasswordFile = passwordFile;
    };
  };
}
