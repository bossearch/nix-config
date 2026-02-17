{
  config,
  inputs,
  lib,
  ...
}: let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  config = lib.mkIf config.spec.sops {
    sops = {
      age.sshKeyPaths = map getKeyPath keys;
      defaultSopsFile = ../../../hosts/${config.spec.hostname}/secrets.yaml;
    };
  };
}
