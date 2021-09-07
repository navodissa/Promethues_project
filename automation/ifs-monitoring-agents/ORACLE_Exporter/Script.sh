#!/bin/bash

xx=`ls -1 Inventory_ORACLE_DB_[1-9].yml`
echo $xx
for i in $xx
do
        cp $i ./oracledb-static-vars.yml
        ansible-playbook -i inventory_new.cfg oracle-node-exporter.yml
done