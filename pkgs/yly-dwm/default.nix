{ pkgs 
, lib
, stdenv
, fetchgit
, libX11
, libXft
, libXinerama
}:

stdenv.mkDerivation (finalAttrs: {

  pname = "yly-dwm";
  version = "1.0.1";

  src = fetchgit {
    url = "https://github.com/ylyhappy-hello/dwm.git";
    rev = "1d3c3af621ffe28675e25395c71df9ca15698015";
    sha256 = "sha256-rFZkNlSqcD0urmvk9Ka/yvWLamvNu/N826VQ7TZAL04=";
  };
  scripts = fetchgit {
    url = "https://github.com/ylyhappy-hello/scripts.git";
    rev = "b4dea2b92e426d97d72e690f0909cb1b6737c421";
    sha256 = "sha256-XJAnTKHvdR4CRBMEpVFzTHBdAgBvbYR0nTdpgnIj/uM=";
  };

  buildInputs = [ libX11 libXinerama libXft ] ++ (with pkgs; [acpi (nerdfonts.override { fonts = [ "JetBrainsMono" "OpenDyslexic" ]; })]);
  prePatch = ''sed -i "s@/usr/local@$out@" config.mk'';

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  installPhase = ''
    mkdir $out/dwm -p
    mkdir $out/scripts -p


    sed -i "s@~/dwm@$out/dwm@"         config.h
    sed -i "s@~/scripts@$out/scripts@" config.h
    sed -i 's@"JetBrainsMono Nerd Font:style=medium:size=13", "monospace:size=13"@"OpenDyslexicAlt Nerd Font:style=regular:size=14"@' config.h

    sed -i "s@~/dwm/statusbar/temp@/tmp/dwm/statusbar@"  autostart.sh
    sed -i "s@~/dwm@$out/dwm@"                           autostart.sh
    sed -i "s@~/scripts@$out/scripts@"                   autostart.sh
    
    sed -i "s@flameshot@${pkgs.flameshot}/bin/flameshot@" autostart.sh
    sed -i "s@dunst@${pkgs.dunst}/dunst@"                 autostart.sh
    sed -i "s@feh@${pkgs.feh}/bin/feh@"                   autostart.sh

    sed -i "s@~/wallpaper@$out/dwm/wallpaper@"               autostart.sh
    sed -i "s@~/dwm/statusbar/temp@/tmp/dwm/statusbar@"      statusbar/statusbar.sh
    sed -i "s@~/dwm@$out/dwm@"                               statusbar/statusbar.sh
    sed -i "s@~/scripts@$out/scripts@"                       statusbar/statusbar.sh
    sed -i "s@~/dwm/statusbar/temp@/tmp/dwm/statusbar@"      statusbar/packages/*.sh
    sed -i "s@~/dwm@$out/dwm@"                               statusbar/packages/*.sh
    sed -i "s@~/scripts@$out/scripts@"                       statusbar/packages/*.sh

    cp $scripts/* $out/scripts -r
    cp ./* $out/dwm -r

    sed -i "s@~/scripts@$out/scripts@" $out/scripts/call_rofi.sh
    sed -i "s@~/scripts@$out/scripts@" $out/scripts/gif_recorder.sh
    sed -i "s@~/dwm@$out/dwm@"         $out/scripts/rofi.sh
    sed -i "s@~/scripts@$out/scripts@" $out/scripts/rofi.sh
    sed -i "s@~/dwm@$out/dwm@"         $out/scripts/set_vol.sh

    make install
  '';


  meta = with lib; {
    description = "dwm 桌面";
    longDescription = ''
      dwm 桌面 fork 于 yaoccc 修改 于 ylyhappy
    '';
    homepage = "https://dwm.suckless.org/";
    #license = licenses.gpl3Plus;
    #maintainers = [ maintainers.eelco ];
    #platforms = platforms.all;
  };
})

