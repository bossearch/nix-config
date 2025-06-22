{
  description = "Minimal NixOS flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, ...} @ inputs: let
    mkMinimal = host:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
            (import ./disko.nix {inherit inputs;})
            ./hardware-configuration.nix
            ./minimal.nix
            ({...}: {networking.hostName = host;})
          ]
          ++ luksKeyModule ++ wifiModule;
      };
  in {
    nixosConfigurations = {
      pc = mkMinimal "pc";
      vm = mkMinimal "vm";
    };
  };
}
