{pkgs,user, ...}:
{
  

  systemd.services.fix-sddm-avatar = {
    description = "fix sddm avator, ~/ ~/.face.icon, permission";
    script = ''
      if [ -f /home/${user}/.face.icon ]; then
        if [ -L /home/${user}/.face.icon ]; 
        then
          icon=$(${pkgs.coreutils-full}/bin/readlink /home/${user}/.face.icon)
          icon=$(readlink $icon)
          rm /home/${user}/.face.icon
          cp $icon /home/${user}/.face.icon
          ${pkgs.acl}/bin/setfacl -m u:sddm:x /home/${user} 
          ${pkgs.acl}/bin/setfacl -m u:sddm:r /home/${user}/.face.icon
        else
          ${pkgs.acl}/bin/setfacl -m u:sddm:x /home/${user} 
          ${pkgs.acl}/bin/setfacl -m u:sddm:r /home/${user}/.face.icon
        fi
      fi
    '';
    wantedBy = ["multi-user.target"];
  };
  environment.systemPackages = [
    pkgs.acl
  ];
}
