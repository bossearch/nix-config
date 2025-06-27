{
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Define a user account.
  sops.secrets.passwd.neededForUsers = true;

  users = {
    mutableUsers = false;
    users.${config.spec.userName} = {
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
        ])
      ];
      hashedPasswordFile = config.sops.secrets.passwd.path;
    };
  };

  environment.persistence = lib.mkIf config.spec.impermanence {
    "/persist" = {
      users.${config.spec.userName}.directories = ["."];
    };
  };

  system.activationScripts.persistent-dirs.text = lib.mkIf config.spec.impermanence (
    let
      mkHomePersist = user:
        lib.optionalString user.createHome ''
          mkdir -p /persist/${user.home}
          chown ${user.name}:${user.group} /persist/${user.home}
          chmod ${user.homeMode} /persist/${user.home}
        '';
      users = lib.attrValues config.users.users;
    in
      lib.concatLines (map mkHomePersist users)
  );
}
