#!/bin/bash


 oracle_var=$1

 TARGETFILE=config_oracle_TESTversion_APPS9_Central_$oracle_var.yaml


 
 #awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt > host_details.txt

 #Apphost_IP=`cat host_details.txt | grep address | awk '{print $2}'`
 fqdn=`cat host_details.txt | grep ${oracle_var}_APPS_FQDN | awk '{print $2}'`
 ORACLE_DB_1_NAGIOS_MONITOR_USER=`cat host_details.txt | grep _${oracle_var}_NAGIOS_MONITOR_USER | awk '{print $2}'`
 ORACLE_DB_1_NAGIOS_MONITOR_PASSWORD=`cat host_details.txt | grep _${oracle_var}_NAGIOS_MONITOR_PASSWORD | awk '{print $2}'`
 ORACLE_DB_1_PORT=`cat host_details.txt | grep _${oracle_var}_PORT | awk '{print $2}'`
 ORACLE_DB_1_NAME=`cat host_details.txt | grep _${oracle_var}_NAME | awk '{print $2}'`
 TEST_CUSTOMER_CODE=`echo $ORACLE_DB_1_NAME | cut -c1-4`
 HOST_IP=`cat host_details.txt | grep address | awk '{print $2}'`
 envtype=`cat host_details.txt | grep _${oracle_var}_ENV | awk '{print $2}'`
 


echo "username: ${ORACLE_DB_1_NAGIOS_MONITOR_USER}" >> $TARGETFILE
echo "password: ${ORACLE_DB_1_NAGIOS_MONITOR_PASSWORD}" >> $TARGETFILE
echo "host: ${HOST_IP}" >> $TARGETFILE
echo "port: ${ORACLE_DB_1_PORT}" >> $TARGETFILE
echo "sid: ${ORACLE_DB_1_NAME}" >> $TARGETFILE
echo "custid: ${TEST_CUSTOMER_CODE}" >> $TARGETFILE
echo "envtype: ${envtype}" >> $TARGETFILE

rm -rf Inventory_Oracle.cfg
cat config_oracle_TESTversion_APPS9_Central_$oracle_var.yaml >> Inventory_$oracle_var.yml

