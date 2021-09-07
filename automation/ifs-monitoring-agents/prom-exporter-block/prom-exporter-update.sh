mysql_user='TESTsrvadmin@'$PREFIX'-'$ENV'-eu-mysql'
mysql_host=$PREFIX'-'$ENV'-eu-mysql.mysql.database.azure.com'

echo $mysql_user
echo $mysql_host

rm -rf prometheus_exporters_block.yml > /dev/null
cat oracledb-static-vars.yml > tmp_var.yml
cat tmp_var.yml
while read line
do
  line=`echo $line|sed -e "s/: /=/g"`
  eval  export "$line"
done < "tmp_var.yml"
rm -rf tmp_var.yml > /dev/null


cat oracledb_details.yml > tmp_var.yml
cat tmp_var.yml
while read line
do
  line=`echo $line|sed -e "s/: /=/g"`
  eval  export "$line"
done < "tmp_var.yml"
rm -rf tmp_var.yml > /dev/null


if [ "$custid" = "" ];then
  echo -e "Unable to fetch custid"
  exit 1
fi

if [ "$envtype" = "" ];then
  echo -e "Unable to fetch envtype"
  exit 1
fi

if [ "$subscription_id" = "" ];then
  echo -e "Unable to fetch subscription_id"
  exit 1
fi

if [ "$ALLREGION" = "us" ];then
  client_secret=`echo $us_client_secret`
  client_id=`echo $us_client_id`
else
  client_secret=`echo $eu_client_secret`
  client_id=`echo $eu_client_id`
fi

if [ "$client_secret" = "" ];then
  echo -e "Unable to fetch client_secret"
  exit 1
fi

if [ "$client_id" = "" ];then
  echo -e "Unable to fetch client_id"
  exit 1
fi

if [ "$TESTversion" = "" ];then
  echo -e "Unable to fetch TESTversion"
  exit 1
fi

if [ "$mysqladmin_password" = "" ];then
  echo -e "Unable to fetch mysqladmin_password"
  exit 1
fi

mysql_query="SELECT ID from oracle_exporter_port where CUST_DB_NAME='$sid'"
oracledb_exporter_port=`mysql --user="$mysql_user" --password="$mysqladmin_password" prometheus_service_ports --host="$mysql_host" --batch --skip-column-names --execute="$mysql_query"`
echo -e "Port for $sid is $oracledb_exporter_port"

if [ "$oracledb_exporter_port" == "" ];then
  echo -e "Unable to fetch Oracle DB port"
  exit 1
fi

cp prometheus_exporters_block.tpl tmp.yml
sed -i -e "s/{{ customer_code }}/$custid/g" -e "s/{{ customer_env }}/$envtype/g" -e "s/{{ customer_subscription_id }}/$subscription_id/g" -e "s/{{ customer_client_id }}/$client_id/g" -e "s/{{ customer_client_secret }}/$client_secret/g" -e "s/{{ oracledb_exporter_port }}/$oracledb_exporter_port/g" -e "s/{{ TEST_version }}/$TESTversion/g" tmp.yml
cat tmp.yml >> prometheus_exporters_block.yml
rm -rf tmp.yml > /dev/null

cp prometheus_ora_exporter_block.tpl ora_tmp.yml
sed -i -e "s/{{ customer_code }}/$custid/g" -e "s/{{ customer_env }}/$envtype/g" -e "s/{{ customer_subscription_id }}/$subscription_id/g" -e "s/{{ customer_client_id }}/$client_id/g" -e "s/{{ customer_client_secret }}/$client_secret/g" -e "s/{{ oracledb_exporter_port }}/$oracledb_exporter_port/g" -e "s/{{ TEST_version }}/$TESTversion/g" -e "s/{{ sid }}/$sid/g" ora_tmp.yml
cat ora_tmp.yml >> prometheus_ora_exporter_block.yml
rm -rf ora_tmp.yml > /dev/null
