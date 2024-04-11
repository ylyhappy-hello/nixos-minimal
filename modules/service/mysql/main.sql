ALTER USER 'root'@'localhost' IDENTIFIED BY "${statsConfig.rootPassword}";
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY "${statsConfig.rootPassword}" WITH GRANT OPTION;
CREATE DATABASE ${statsConfig.db};
CREATE TABLE ${statsConfig.db}.ident (name VARCHAR(25) NOT NULL);
GRANT ALL PRIVILEGES ON *.* TO '${statsConfig.user}'@'%' IDENTIFIED BY "${statsConfig.password}" WITH GRANT OPTION;
