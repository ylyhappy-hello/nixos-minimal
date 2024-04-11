{pkgs, ...}:{
  environment.variables.JAVA_HOME = pkgs.jdk8.home;
  environment.sessionVariables = rec {
    JAVA_17_HOME = pkgs.jdk17.home;
  };
  environment.systemPackages = [
    pkgs.jdk8
    pkgs.jdk17
    pkgs.maven
    pkgs.redis
  ];
}
