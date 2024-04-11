{
  fetchurl,
  stdenv,
  lib,
  appimageTools,
  pkgs,
  callPackage,
  ...
}:
let 

  pname = "navicat";
  version = "16.1.2";
  src = fetchurl {
    url = "https://sso.ylyhappy.cn/navicat16-premium-cs.AppImage";
    sha256 = "sha256-jwO22Dw4PGLgcSTQY05/4KvhDGfS2BBAJSXOXViYbNQ=";
  };
  appimageContents = appimageTools.extractType1 {
    inherit pname version src;
  };
  navicat-patcher = callPackage ./patcher.nix {};
in
  stdenv.mkDerivation rec{
  inherit pname version src;
  nativeBuildInputs = with pkgs; [ appimagekit ];
  unpackPhase = ''
    mkdir $out/img $out/bin -p
    cp -r ${appimageContents}/* $out/img
    chmod 755 -R $out/img
  '';
  
  installPhase = ''
    export res="$out/navicat16-premium-cs.AppImage";
    cp ${./libzstd.so.1} $out/img/usr/lib/libzstd.so.1
    cp ${./libmongoc-1.0.so.0} $out/img/usr/lib/libmongoc-1.0.so.0
    cp ${./libmongoc-1.0-1.16.2.so} $out/img/usr/lib/libmongoc-1.0-1.16.2.so
    ${navicat-patcher}/navicat-patcher $out/img
    install -m 444 -D $out/img/${pname}.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=navicat' "Exec=appimage-run $res"
    cp -r $out/img/usr/share/icons $out/share
    appimagetool $out/img $res
    rm -r $out/img
    cp ./RegPrivateKey.pem $out

    echo "${navicat-patcher}/navicat-keygen --text $out/RegPrivateKey.pem" >> $out/bin/navicat-getkey
    chmod +x $out/bin/navicat-getkey
  '';

  meta = with lib; {
    description = "多连接数据库开发工具";
    longDescription = ''
      Navicat Premium 是一套多连接数据库开发工具，让你在单一应用程序中同时连接多种类型的数据库：MySQL、Redis、MariaDB、MongoDB、SQL Server、SQLite、Oracle 和 PostgreSQL，可一次快速方便地访问所有数据库。了解更多 >
    '';
    homepage = "https://www.navicat.com.cn/products";
    # license = licenses.gpl3Plus;
    # maintainers = [ maintainers.eelco ];
    # platforms = platforms.all;
  };
}

