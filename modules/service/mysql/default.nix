{ pkgs, ... }:

let
  db = "test1";
  user = "ylyhappy";
  password = "qwerty666";
  host = "localhost";
  rootPassword = "123456";
in {
  services.mysql = {
    package = pkgs.mysql80;
    enable = true;
    # TODO 这下面一堆东西都不生效， 不知道为什么
    # configFile = pkgs.writeText "my.cnf" ''
    #   [mysqld]
    #   datadir = /var/lib/mysql
    #   bind-address = 127.0.0.1
    #   port = 3336
    #   [client]
    #   user=root
    #   password=${rootPassword}
    #   [client]
    #   user=${user}
    #   password=${password}
    # '';
    # ensureDatabases = [ statsConfig.db ];
    # replication.role = "master";
    # replication.slaveHost = "127.0.0.1";
    # replication.masterUser = "${statsConfig.user}";
    # replication.masterPassword = "${statsConfig.password}";
    # initialScript = pkgs.writeText "setup.sql" ''
    #         ALTER USER 'root'@'localhost' IDENTIFIED BY "${statsConfig.rootPassword}";
    #   	    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY "${statsConfig.rootPassword}" WITH GRANT OPTION;
    #   	    CREATE DATABASE ${statsConfig.db};
    #   	    CREATE TABLE ${statsConfig.db}.ident (name VARCHAR(25) NOT NULL);
    #         GRANT ALL PRIVILEGES ON *.* TO '${statsConfig.user}'@'%' IDENTIFIED BY "${statsConfig.password}" WITH GRANT OPTION;
    #         plush privileges;
    #   	  '';

    # ensureUsers = [{
    #   name = "${statsConfig.user}";
    #   ensurePermissions = { "${statsConfig.db}.*" = "ALL PRIVILEGES"; };
    # }];

  };
}

