{
  hosts,
  pkgs,
  ...
}: {
  services.tor = {
    enable = hosts.proxychains;
  };
  programs.proxychains = {
    enable = hosts.proxychains;
    package = pkgs.proxychains-ng;
    proxyDNS = true;
    tcpReadTimeOut = 15000;
    tcpConnectTimeOut = 8000;

    # Define proxies
    proxies = {
      tor = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 9050; # Tor's default SOCKS5 proxy
      };

      usa1 = {
        enable = false;
        type = "socks5";
        host = "139.64.165.22";
        port = 1080;
      };
    };

    # Proxy chaining configuration
    chain = {
      type = "strict";
      # length = 1; # Number of proxies in the chain (only for random)
    };
  };
}
