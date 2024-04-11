{pkgs, ...}:{
  fonts.packages = with pkgs; [
    source-han-sans
    wqy_zenhei
    (nerdfonts.override { fonts = [ "OpenDyslexic" "Iosevka" ]; })
    ((nerdfonts.override { fonts = [ "JetBrainsMono" ]; }).overrideAttrs (oldAttrs: { version = "2.3.2"; } ) )
  ];
}
