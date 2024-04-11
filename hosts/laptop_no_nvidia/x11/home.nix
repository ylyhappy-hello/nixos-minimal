{ config, lib, pkgs, user, ... }:

{
  imports = [
    ../../../modules/theme/catppuccin-dark/common/fcitx5
  ] ++ (import ../../../modules/shell/home.nix)
    ++ (import ../../../modules/programs/x11)
    ++ (import ../../../modules/develop/home.nix) 
    ++ (import ../../../modules/editors/home.nix);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    
  };
  programs = {
    home-manager.enable = true;
  };
  home.file.".face.icon".source = ./avatar.jpg;

  home.stateVersion = "23.11";
}
