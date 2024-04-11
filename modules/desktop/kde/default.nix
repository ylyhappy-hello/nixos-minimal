{pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.sddm.theme = "${(pkgs.fetchFromGitHub {
  #   owner = "MarianArlt";
  #   repo = "kde-plasma-chili";
  #   rev = "a371123959676f608f01421398f7400a2f01ae06";
  #   sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
  # })}";
  services.xserver.displayManager.sddm.theme = "materia-dark";
  services.xserver.desktopManager.plasma5.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    # gwenview
    # okular
    oxygen
    khelpcenter
    # konsol
    plasma-browser-integration
    print-manager
  ];
  environment.systemPackages = with pkgs; [ materia-kde-theme realvnc-vnc-viewer ];
  services.xserver.displayManager.defaultSession = "plasmawayland";
}
