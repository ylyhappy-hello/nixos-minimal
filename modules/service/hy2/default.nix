{user, pkgs, ...}:
{
  systemd.services.hy2 = {
    description = "auto started hy2";
    serviceConfig.ExecStart = ''
    ${./hysteria-linux-amd64} -c ${./config.yaml} client
    '';
    wantedBy = ["network-online.target"];
  };
}
