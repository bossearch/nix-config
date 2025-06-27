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

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
