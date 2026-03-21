{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOs/nixpkgs/nixos-25.11";
    systems.url = "github:nix-systems/default-linux";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    # Third party programs, packaged with nix
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lan-mouse = {
      url = "github:feschber/lan-mouse";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Third party programs, not packaged with nix
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

    # My own program, packaged with nix
    copas = {
      url = "github:bossearch/copas";
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
          config = {
            allowUnfree = true;
          };
        }
    );
    mylib = import ./libs {inherit lib;};
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
          inherit inputs outputs mylib;
        };
      };
      # Virtual Machine
      stagea = lib.nixosSystem {
        modules = [./hosts/stagea];
        specialArgs = {
          inherit inputs outputs mylib;
        };
      };
    };

    homeConfigurations = {
      # Main Desktop
      "bosse@silvia" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        modules = [./homes/bosse/silvia.nix];
        extraSpecialArgs = {
          inherit inputs outputs mylib;
          hosts = self.nixosConfigurations.silvia.config.hosts;
        };
      };

      # Virtual Machine
      "bosse@stagea" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        modules = [./homes/bosse/stagea.nix];
        extraSpecialArgs = {
          inherit inputs outputs mylib;
          hosts = self.nixosConfigurations.stagea.config.hosts;
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
