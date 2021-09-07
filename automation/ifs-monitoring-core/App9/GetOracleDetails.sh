#!/bin/bash
 
hostname=$1
echo $hostname
rm -rf host_details.txt oracle_list
#rm -rf Inventory_Oracle_DB_1.yml Inventory_Oracle_DB_2.yml Inventory_Oracle_DB_3.yml

 #awk -vRS='' '/'$hostname'/{print}' hosts.txt >> host_details.txt
awk -vRS='' '/'$hostname'/{print}' hosts.txt > host_details.txt
grep _ORACLE_DB_[1-9]_ENV host_details.txt |cut -c4-14 > oracle_list.txt
cat host_details.txt
cat oracle_list.txt
rm -rf config_oracle_TESTversion_APPS9_Central_*.yaml

while read -r line; do
sh GenerateOracleConfigFile.sh $line
done < oracle_list.txt

rm -rf oracle_list.txt host_details.txt
