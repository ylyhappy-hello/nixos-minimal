{ callPackage, lib, stdenv, fetchzip, pkgs }:

stdenv.mkDerivation (finalAttrs: {
  pname = "apifox";
  version = "linux-latest";
  src = fetchzip {
    stripRoot = false;
    url = "https://cdn.apifox.cn/download/Apifox-${finalAttrs.version}.zip";
    sha256 = "sha256-8fKu417+Os/VPoYwa/JTUhXTcU3GGLQnpvIbjzkFhkQ=";
  };

  installPhase = ''
    install -Dm755 "Apifox.AppImage" "$out/opt/apifox/Apifox.AppImage"
    mkdir -p "$out/bin" $out/share/applications 
    ln -sf "$out/opt/apifox/Apifox.AppImage" "$out/bin"
    runHook postInstall
  '';

  postInstall = ''
        # mkdir -p "$out/share/icons/hicolor/scalable/apps"
        echo "
        [Desktop Entry]
        Name=Apifox
        Exec=appimage-run $out/opt/apifox/Apifox.AppImage %U
        Comment=API 文档、API 调试、API Mock、API 自动化测试
        Comment[zh_CN]=API 文档、API 调试、API Mock、API 自动化测试
        Terminal=false
        Icon=apifox
        Type=Application
        StartupNotify=true
        StartupWMClass=Apifox
        Categories=Network;Development;Utility;  
        " > "$out/share/applications/apifox.desktop"
        chmod 644 $out/share/applications/apifox.desktop
        install -Dm644 ${./apifox.svg} "$out/share/icons/apifox.svg"
        install -Dm644 ${
          ./apifox.svg
        } "$out/share/icons/hicolor/scalable/apps/apifox.svg"
  '';
  # 这个东西在安装完了就自动删除了？，反正没有这个命令
  # buildInputs = with pkgs; [ appimage-run ];

  meta = with lib; {
    description = "API 文档、API 调试、API Mock、API 自动化测试 、API 一体化协作平台";
    longDescription = ''
      更先进的 API 设计/开发/测试工具
      Apifox = Postman + Swagger + Mock + JMeter.
    '';
    homepage = "https://apifox.com/";
    # changelog = "https://git.savannah.gnu.org/cgit/hello.git/plain/NEWS?h=v${finalAttrs.version}";
    # license = licenses.gpl3Plus;
    # maintainers = [ maintainers.eelco ];
    # platforms = platforms.all;
  };
})
