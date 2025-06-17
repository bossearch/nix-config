{
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./colors.nix
      ./firewall.nix
      ./keyring.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      # ./proxy.nix
      ./shell.nix
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.spec.userName} = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video"];
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
