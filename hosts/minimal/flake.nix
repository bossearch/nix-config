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
        modules = [
          (import ./disko.nix {inherit inputs;})
          ./hardware-configuration.nix
          ./minimal.nix
          ({...}: {networking.hostName = host;})
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkMinimal "pc";
      vm = mkMinimal "vm";
    };
  };
}
