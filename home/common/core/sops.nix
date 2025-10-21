{
  inputs,
  config,
  pkgs,
  ...
}: let
  cacheDir = "${config.home.homeDirectory}/.cache/${config.spec.userName}";
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  home.packages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../${config.spec.userName}/secrets.yaml;
    secrets = {
      "Latitude" = {};
      "Longitude" = {};
      "deepl" = {};
      "transmission" = {};
    };

    templates = {
      "coordinate" = {
        content = ''
          Latitude: ${config.sops.placeholder."Latitude"}
          Longitude: ${config.sops.placeholder."Longitude"}
        '';
        path = "${cacheDir}/coordinate";
        mode = "0400";
      };
      "deepl" = {
        content = config.sops.placeholder."deepl";
        path = "${cacheDir}/deepl";
        mode = "0400";
      };
      "transmission" = {
        content = config.sops.placeholder."transmission";
        path = "${cacheDir}/transmission";
        mode = "0400";
      };
    };
  };
}
