#!/bin/bash
dir1="/home/gitlab-runner/builds/BxGAiyJS/0/automation_templates/apps10_prometheus"

cd $dir1/automation/TEST-monitoring-agents/ORACLE_Exporter
pwd
xx=`ls -1 Inventory_ORACLE_DB_[1-9].yml`

echo $xx
cd $dir1/automation/TEST-monitoring-agents/prom-exporter-block
pwd

for i in $xx
do
        pwd
        cp $dir1/automation/terraform/file/export-variables.sh .
        sh -x export-variables.sh
#        cp $dir1/automation/TEST-monitoring-agents/ORACLE_Exporter/$i .
        cp $dir1/automation/TEST-monitoring-agents/ORACLE_Exporter/$i ./oracledb_details.yml
        cp $dir1/automation/TEST-monitoring-core/ansible/inventory_new.cfg .
        ansible-playbook -i inventory_new.cfg prom-exporter-update.yml --extra-vars "DB_Inventory_File=$i"
done
