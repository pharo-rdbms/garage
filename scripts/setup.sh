#!/usr/bin/bash

if [[ "$1" == "sqlite3" ]]; then
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configureSqlite3";
elif [[ "$1" == "postgresV2"]] then
  psql -c 'create user sodbxtest createdb createuser password 'postgres';' -U postgres;
  psql -c 'alter user postgres password 'postgres';' -U postgres;
  ./pharo Pharo.image eval --save "GAContinuousIntegrationConfiguration new configurePostgresql";
else
  echo "Unsupported database ${1}";
fi;
