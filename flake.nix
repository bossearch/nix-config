{
  description = "A very basic flake";

  inputs = {
    # Nix ecosystem
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Third party programs, packaged with nix
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-on-droid,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          overlays = builtins.attrValues outputs.overlays;
          config.allowUnfree = true;
          allowUnfreePredicate = _: true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    nixosConfigurations = {
      # Main Desktop
      silvia = lib.nixosSystem {
        modules = [./hosts/silvia];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # Virtual Machine
      stagea = lib.nixosSystem {
        modules = [./hosts/stagea];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      # Main Desktop
      "bosse@silvia" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        modules = [./home/bosse/silvia.nix];
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # Virtual Machine
      "bosse@stagea" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        modules = [./home/bosse/stagea.nix];
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # Android
    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = pkgsFor.aarch64-linux;
        modules = [
          (import ./hosts/droid {
            inherit inputs outputs lib;
            pkgs = pkgsFor.aarch64-linux;
          })
        ];
      };
    };
  };
}
