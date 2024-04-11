{ inputs, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "materia-dark";

  environment.systemPackages = with pkgs; [ 
  materia-kde-theme
  rofi acpi gnumake
  cmake picom 
  #obsidian
  pcmanfm tree
  ocamlPackages.gstreamer
  libsForQt5.qt5.qtgraphicaleffects
  ];
  services.xserver.windowManager.dwm.package = pkgs.yly-dwm;
  services.xserver.windowManager.dwm.enable = true;
}
