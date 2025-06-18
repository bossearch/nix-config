{
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./boot.nix
      #./colors.nix
      ./firewall.nix
      #./keyring.nix
      #./locale.nix
      #./network.nix
      ./nix.nix
      ##./proxy.nix
      #./shell.nix
      ./ssh.nix
      ./sops.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  networking = {
    hostName = "${config.spec.hostName}";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "${config.spec.timeZone}";

  # Define a user account.
  sops.secrets.passwd.neededForUsers = true;
  users = {
    mutableUsers = false;
    users.${config.spec.userName} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
      hashedPasswordFile = config.sops.secrets.passwd.path;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
