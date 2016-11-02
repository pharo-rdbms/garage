case $1 in
sqlite3)
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configureSqlite3"
  ;;
mysql)
  mysql -uroot -e "CREATE DATABASE sodbxtest /*\!40100 DEFAULT CHARACTER SET utf8 */;"
  mysql -uroot -e "CREATE USER sodbxtest@localhost IDENTIFIED BY 'sodbxtest';"
  mysql -uroot -e "GRANT ALL PRIVILEGES ON sodbxtest.* TO 'sodbxtest'@'localhost';"
  mysql -uroot -e "FLUSH PRIVILEGES;"
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configureMysql"
  ;;
postgresV2)
  psql -c "create user sodbxtest createdb createuser password 'sodbxtest';" -U postgres;
  psql -c "alter user postgres password 'postgres';" -U postgres;
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configurePostgresql";
  ;;
*)
  echo "Unsupported database $1"
  ;;
esac
