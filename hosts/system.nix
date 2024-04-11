{ config, pkgs, inputs, ... }:

{
  imports = (import ../modules/service);
  time.timeZone = "Asia/Shanghai";
  # i18n.defaultLocale = "en_US.UTF-8";
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.extraConfig = ''
    PubkeyAuthentication yes
  '';
  networking.firewall.enable = false;
  networking.wireless.enable = false;
  networking.networkmanager ={
    enable = true;
    unmanaged = ["type:wifi"];
  };
  # networking.proxy.default = "http://127.0.0.1:7888";
  networking.proxy.noProxy = "127.0.0.1,localhost,work.com";
  nix = {
    settings = {
      trusted-substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  services.dbus.enable = true;
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      neovim
      wget
      neofetch
      eza
      gcc
      # clang
      # cargo
      # zig
      # p7zip
      # atool
      # unzip
      gnome.gnome-keyring
      glib
      xdg-utils
      pciutils
      gdb
      socat
      zip
      rar
      frp
      # sops
    ];
  };
  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-23.11";
    };
    stateVersion = "23.11";
  };
}
