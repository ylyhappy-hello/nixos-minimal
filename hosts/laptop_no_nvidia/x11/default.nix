{ config, pkgs, user, inputs, lib, ... }:

{
  imports = 
    (import ../../../modules/virtualisation)
    ++ (import ../../../modules/editors) ++
    (import ../../../modules/shell)
    ++ (import ../../../modules/develop) ++ [
      # ../hardware-configuration.nix
      ../../../modules/fonts
    ] ++ [ ../../../modules/desktop/kde];
  users.mutableUsers = false;
  users.users.root = { };
  users.users.${user} = {
    initialHashedPassword =
      "$6$MHD44lZkFNlW9/xd$SO8ZIZB/jRtT1T86IjdEZ8PNfEKErDguozNeC.5LDk9yz0UJPz4gy1QGUIPBKmYVil7m0c76oeWnSkbZLThYK/";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "networkmanager"
      "network"
      "wheel"
      "video"
      "libvirt"
      "docker"
      "vboxusers"
    ];
    openssh.authorizedKeys.keys = [ ];
    packages = (with pkgs; [
      navicat
      qbittorrent
      meld
      filezilla
      yazi
    ]);
  };
  boot = {
    loader.systemd-boot.enable = true;
    supportedFilesystems = [ "ntfs" "fat32" "ext4" "exfat" "btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
    ];
    initrd.network.ssh.enable = true;
  };


  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-table-extra ];
  };
  environment = {
    variables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };
    systemPackages = with pkgs; [
      libnotify
      xclip
      xorg.xrandr
      polkit_gnome
      xorg.xev
      linux-firmware
      sshpass
    ];
  };

  services.xserver = { xkbOptions = "caps:escape"; };
  console.useXkbConfig = true;

  services.xserver.libinput = {
    enable = true;
  };
}
