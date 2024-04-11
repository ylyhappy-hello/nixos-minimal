
{pkgs, ... }:
let unstable = import <nixpkgs-unstable> {};
in
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "materia-dark";

  environment.systemPackages = with pkgs; [ 
  materia-kde-theme
  rofi lsof acpi filezilla gnumake
  cmake picom chromium 
  #obsidian
  pcmanfm tree
  tensorrt
  cudaPackages.cudatoolkit
  cudaPackages.cudnn_8_6_0
  ocamlPackages.gstreamer
  libsForQt5.qt5.qtgraphicaleffects
  gst_all_1.gstreamer
  # Common plugins like "filesrc" to combine within e.g. gst-launch
  gst_all_1.gst-plugins-base
  # Specialized plugins separated by quality
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-ugly
  # Plugins to reuse ffmpeg to play almost every video format
  gst_all_1.gst-libav
  # Support the Video Audio (Hardware) Acceleration API
  gst_all_1.gst-vaapi
  ((opencv4.override {
    enableGtk2 = true;
    gtk2 = pkgs.gtk2;
    enableUnfree = true;
    enableCuda = true;
    enableCudnn = true;
    enableFfmpeg = true; #here is how to add ffmpeg and other compilation flags
    }).overrideAttrs (oldAttrs: {
      buildPhase = "cmake --build . -j8";
    }))
  ] ++ (with unstable; [yazi]);
  services.xserver.windowManager.dwm.package = pkgs.yly-dwm;
  services.xserver.windowManager.dwm.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
