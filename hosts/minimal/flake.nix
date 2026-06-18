{
  description = "Minimal NixOS flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkMinimal = user: host: type: disk: swap:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hosts = {
            username = user;
            hostname = host;
            disko = {
              inherit type disk swap;
            };
          };
        };

        modules = let
          luksKeyModule =
            if builtins.pathExists ./luks-key.nix
            then [./luks-key.nix]
            else [];
          wifiModule =
            if builtins.pathExists ./wpa.nix
            then [./wpa.nix]
            else [];
        in
          [
            inputs.disko.nixosModules.disko
            ./disko.nix
            ./hardware-configuration.nix
            ./impermanence.nix
            ./minimal.nix
            ({hosts, ...}: {networking.hostName = hosts.hostname;})
          ]
          ++ luksKeyModule ++ wifiModule;
      };
  in {
    nixosConfigurations = {
      silvia = mkMinimal "bosse" "silvia" "btrfs-luks-impermanence" "/dev/nvme0n1" "32G";
      stagea = mkMinimal "bosse" "stagea" "btrfs-luks-impermanence" "/dev/vda" "0G";
    };
  };
}
