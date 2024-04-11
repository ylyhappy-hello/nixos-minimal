{ fetchgit, fetchzip, stdenv, lib, substituteAll, pkgs, ... }:
stdenv.mkDerivation rec {
  pname = "navicat-keygen";
  version = "9988";
  src = fetchgit {
    url = "https://notabug.org/doublesine/navicat-keygen.git";
    rev = "7804ece6a9cd275c2b8a0cf3bd19c5e20cc11eb8";
    sha256 = "sha256-eT155oozY0V54ccxZq/gzb0/c+MR1PDAG5kZIxE80x4=";
  };
  keystone = fetchgit {
    url = "https://github.com/keystone-engine/keystone.git";
    rev = "1475885daa7e566c064ae9754706e1a0ba24be3b";
    sha256 = "sha256-AHvzu8jxbmIEQVbippsOwW1QCRPSnjGY7NN3e72nga4=";
  };
  unicorn = fetchzip {
    url =
      "https://github.com/unicorn-engine/unicorn/archive/refs/tags/2.0.0.tar.gz";
    sha256 = "sha256-b2YGrPAaaM4zah5Pp3gb8jF5u5IpxPfwuCJy1a5gmZU=";
  };
  patches = ./0001-2023-07-17-15-40-26.patch;
  buildInputs = with pkgs; [ fmt openssl rapidjson ];
  nativeBuildInputs = with pkgs; [ cmake pkg-config python39 ];

  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir ./keystone ./unicorn
    cp $keystone/* -r ./keystone
    chmod 755 -R ./keystone
    cp $unicorn/* -r ./unicorn
    rm build -rf
    mkdir build && cd build
    cd ..
    # cmake -DCMAKE_BUILD_TYPE=Release 
    cmake -S . -B ./build 
    cd build
    cmake --build . -- -j8
    mkdir $out
    cp ./navicat-keygen ./navicat-patcher $out
  '';

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
}
