{
  networking = {
    nameservers = ["127.0.0.1" "::1"];
    networkmanager.dns = "none";
  };

  # Make sure you don't have services.resolved.enable on.
  services.dnscrypt-proxy2 = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv4_servers = true;
      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = true;
      require_dnssec = true;
      require_nolog = true;
      cert_refresh_delay = 240;
      ignore_system_dns = true;
      # DNS cache
      cache = true;
      cache_size = 4096;
      cache_min_ttl = 2400;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;
      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
      sources.relays = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
          "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/relays.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
      listen_addresses = ["127.0.0.1:53" "[::1]:53"];
      server_names = ["cloudflare-security" "cloudflare-security-ipv6"];
      # anonymized_dns = {
      #   routes = [
      #     { server_name = "dnscry.pt-jakarta-ipv4"; via = [ "dnscry.pt-anon-jakarta-ipv4" ]; }
      #     { server_name = "dnscry.pt-jakarta-ipv6"; via = [ "dnscry.pt-anon-jakarta-ipv6" ]; }
      #   ];
      #   skip_incompatible = true;
      # };
    };
  };

  # Make sure to load dnscrypt-proxy2 after network
  systemd.services.dnscrypt-proxy2 = {
    after = ["network-online.target"];
    wants = ["network-online.target"];
  };
}
