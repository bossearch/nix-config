{
  config,
  hosts,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.wireguard-tools];

  sops.secrets.warp = lib.mkIf (hosts.hostname == "silvia") {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.wg-quick.interfaces.warp = lib.mkIf (hosts.hostname == "silvia") {
    autostart = true;
    mtu = 1280;
    address = [
      "172.16.0.2/32"
      "2606:4700:110:83c9:c80a:e2bc:3296:bbc8/128"
    ];
    privateKeyFile = config.sops.secrets.warp.path;

    peers = [
      {
        publicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";
        allowedIPs = ["0.0.0.0/0" "::/0"];
        endpoint = "162.159.192.1:2408"; # ipv4 endpoint
        persistentKeepalive = 25;
      }
    ];
  };

  systemd.services.wg-quick-warp = lib.mkIf (hosts.hostname == "silvia") {
    after = ["network-online.target" "dnscrypt-proxy.service" "nss-lookup.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };
}
