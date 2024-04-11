{ pkgs, ... }: {
  programs.proxychains.enable = true;
  programs.proxychains.proxies = {
    x1 = {
      type = "socks4";
      host = "127.0.0.1";
      port = 7891;
      enable = true;
    };
    y1 = {
      type = "socks5";
      host = "127.0.0.1";
      port = 7891;
      enable = true;
    };
    x2 = {
      type = "http";
      host = "127.0.0.1";
      port = 7890;
      enable = true;
    };
  };
}
