{ lib, pkgs, user, ... }:

{
  # home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
  home.file.".config/fish/functions/im_change.fish".text = import ./functions/im_change.nix;
  home.file.".config/fish/functions/ylyhappy.fish".text = import ./functions/ylyhappy.nix;
  home.file.".config/fish/functions/set_variables.fish".text = import ./functions/set_variables.nix;
  home.file.".config/fish/functions/genVimMapNix.fish".source = ./functions/genVimMapNix.fish;
  home.file.".config/fish/functions/rv.fish".source = ./functions/rv.fish;
  # home.file.".config/fish/conf.d/st_msg.fish".text = import ./conf.d/st_msg.nix;
}
