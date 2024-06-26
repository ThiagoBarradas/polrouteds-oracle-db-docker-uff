#!/bin/bash

echo "### INITIALIZING ###"
exit | sqlplus -S SYSTEM/PASSPASS@localhost:1521/PolRouteDS @/tmp/scripts/drop_tables.sql
exit | sqlplus -S SYSTEM/PASSPASS@localhost:1521/PolRouteDS @/tmp/scripts/create_database.sql
exit | sqlplus -S SYSTEM/PASSPASS@localhost:1521/PolRouteDS @/tmp/scripts/create_database_frag.sql