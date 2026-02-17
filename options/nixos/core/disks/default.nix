{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./btrfs-impermanence.nix
    ./btrfs-luks-impermanence.nix
    ./btrfs-luks.nix
    ./ext4-luks.nix
    ./ext4.nix
  ];
}
