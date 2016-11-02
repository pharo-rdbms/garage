case $1 in
sqlite3)
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configureSqlite3"
  ;;
mysql)
  mysql -uroot -e "CREATE USER sodbxtest@localhost IDENTIFIED BY 'sodbxtest';"
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
