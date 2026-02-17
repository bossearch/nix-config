{hosts, ...}: {
  # make sure you don't have services.resolved.enable on.
  services.dnscrypt-proxy = {
    enable = hosts.dnscrypt;
    # settings reference:
    # https://github.com/dnscrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv4_servers = true;
      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = true;
      require_dnssec = true;
      require_nolog = true;
      cert_refresh_delay = 240;
      ignore_system_dns = true;
      # dns cache
      cache = true;
      cache_size = 4096;
      cache_min_ttl = 2400;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;
      # add the dns source types you want to use
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/dnscrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "rwqf6lrcga9i53mlyeco4izt51tgppvwucnsch1cbm0qtaln73y7gfo3";
      };
      listen_addresses = ["127.0.0.1:53" "[::1]:53"];
      # dnscrypt protocol
      # server_names = ["quad9-dnscrypt-ip4-filter-pri" "quad9-dnscrypt-ip6-filter-pri"];
      server_names = ["adguard-dns" "adguard-dns-ipv6"];
      # doh protocol
      # server_names = ["cloudflare-security" "cloudflare-security-ipv6"];
      # server_names = ["quad9-doh-ip4-port443-filter-pri" "quad9-doh-ip6-port443-filter-pri"];
      # server_names = ["adguard-dns-doh" "adguard-dns-doh-ipv6"];
    };
  };
}
