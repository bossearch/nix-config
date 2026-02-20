{
  config,
  hosts,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [./monitor.nix];
  options.homes = mkOption {
    type = types.submodule {
      options = {
        nerdfont = mkOption {
          default = "CommitMono";
          type = types.enum [
            "0xProto"
            "3270"
            "AdwaitaMono"
            "Agave"
            "AnonymicePro"
            "Arimo"
            "AtkynsonMono"
            "AurulentSansM"
            "BigBlueTerm"
            "BitstromWera"
            "BlexMono"
            "CaskaydiaCove"
            "CaskaydiaMono"
            "CodeNewRoman"
            "ComicShannsMono"
            "CommitMono"
            "Cousine"
            "D2CodingLigature"
            "DaddyTimeMono"
            "DejaVuSansM"
            "DepartureMono"
            "DroidSansM"
            "EnvyCodeR"
            "FantasqueSansM"
            "FiraCode"
            "FiraMono"
            "GeistMono"
            "GoMono"
            "GoHuFont"
            "Hack"
            "Hasklug"
            "HeavyData"
            "Hurmit"
            "iMWriting"
            "Inconsolata"
            "InconsolataGo"
            "Inconsolata LGC"
            "IntoneMono"
            "Iosevka"
            "IosevkaTerm"
            "IosevkaTermSlab"
            "JetBrainsMono"
            "Lekton"
            "LiterationMono"
            "Lilex"
            "MartianMono"
            "MesloLG"
            "Monaspice"
            "Monofur"
            "Monoid"
            "Mononoki"
            "M+"
            "Noto"
            "OpenDyslexic"
            "Overpass"
            "ProFont"
            "ProggyClean"
            "RecMono"
            "RobotoMono"
            "ShureTechMono"
            "SauceCodePro"
            "SpaceMono"
            "Symbols"
            "Terminess"
            "Tinos"
            "Ubuntu"
            "UbuntuMono"
            "UbuntuSans"
            "VictorMono"
            "ZedMono"
          ];
        };
        cursor = mkOption {
          default = "macOS";
          type = types.enum [
            "macOS"
          ];
        };
        icon = mkOption {
          default = "Papirus-Dark";
          type = types.enum [
            "Papirus-Dark"
            "Papirus-Light"
          ];
        };
        ## move buku as firefox submodule
        # optional modules
        firefox = mkOption {
          default = {};
          type = types.submodule {
            options = {
              enable = mkOption {
                default = false;
                type = types.bool;
              };
              allowlist = lib.mkOption {
                type = types.listOf types.str;
                default = [];
              };
            };
          };
        };
        game = mkOption {
          default = {};
          type = types.submodule {
            options = {
              lsfg = mkOption {
                default = false;
                type = types.bool;
              };
              lutris = mkOption {
                default = false;
                type = types.bool;
              };
              prismlauncher = mkOption {
                default = false;
                type = types.bool;
              };
            };
          };
        };
        llm = mkOption {
          default = false;
          type = types.bool;
        };
        nchat = mkOption {
          default = false;
          type = types.bool;
        };
        neomutt = mkOption {
          default = false;
          type = types.bool;
        };
        newsboat = mkOption {
          default = false;
          type = types.bool;
        };
        nyaa = mkOption {
          default = false;
          type = types.bool;
        };
        alacritty = mkOption {
          default = false;
          type = types.bool;
        };
        copas = mkOption {
          default = false;
          type = types.bool;
        };
        dunst = mkOption {
          default = false;
          type = types.bool;
        };
        feh = mkOption {
          default = false;
          type = types.bool;
        };
        gowall = mkOption {
          default = false;
          type = types.bool;
        };
        kdeconnect = mkOption {
          default = false;
          type = types.bool;
        };
        kitty = mkOption {
          default = false;
          type = types.bool;
        };
        lanmouse = mkOption {
          default = false;
          type = types.bool;
        };
        mpv = mkOption {
          default = false;
          type = types.bool;
        };
        nautilus = mkOption {
          default = false;
          type = types.bool;
        };
        obsidian = mkOption {
          default = false;
          type = types.bool;
        };
        spicetify = mkOption {
          default = false;
          type = types.bool;
        };
        vaults = mkOption {
          default = false;
          type = types.bool;
        };
        vesktop = mkOption {
          default = false;
          type = types.bool;
        };
        waybar = mkOption {
          default = false;
          type = types.bool;
        };
        zathura = mkOption {
          default = false;
          type = types.bool;
        };
      };
    };
  };
  config = {
    _module.args.homes = config.homes;
    homes = lib.mkIf (!hosts.gui.enable) {
      alacritty = lib.mkForce false;
      copas = lib.mkForce false;
      dunst = lib.mkForce false; #*
      feh = lib.mkForce false;
      firefox.enable = lib.mkForce false; #*
      game = {
        lsfg = lib.mkForce false; #*
        lutris = lib.mkForce false; #*
        prismlauncher = lib.mkForce false;
      };
      gowall = lib.mkForce false; #*
      kdeconnect = lib.mkForce false;
      kitty = lib.mkForce false;
      lanmouse = lib.mkForce false;
      mpv = lib.mkForce false; #*
      nautilus = lib.mkForce false; #*
      nyaa = lib.mkForce false;
      obsidian = lib.mkForce false;
      spicetify = lib.mkForce false;
      vaults = lib.mkForce false;
      vesktop = lib.mkForce false; #*
      waybar = lib.mkForce false; #*
      zathura = lib.mkForce false;
    };
  };
}
