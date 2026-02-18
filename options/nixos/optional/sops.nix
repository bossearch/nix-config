{
  config,
  hosts,
  inputs,
  lib,
  ...
}: let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = lib.mkIf hosts.sops {
    age.sshKeyPaths = map getKeyPath keys;
    defaultSopsFile = ../../../hosts/${hosts.hostname}/secrets.yaml;
  };
}
