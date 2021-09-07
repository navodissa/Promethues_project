#!/bin/bash


 mws_var=$1

 TARGETFILE=config_TESTversion_APPS9_MWS_$mws_var.yaml

 
#  awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt > host_details.txt

host_ip_local=`cat host_details.txt | grep address | awk '{print $2}'`
adminport=`cat host_details.txt | grep ${mws_var}_ADMIN_SERVER_PORT | awk '{print $2}'`
fqdn=`cat host_details.txt | grep ${mws_var}_APPS_FQDN | awk '{print $2}'`
mws_TESTmon_user=`cat host_details.txt | grep _${mws_var}_USER | awk '{print $2}'`
mws_TESTmon_password=`cat host_details.txt | grep _${mws_var}_PASSWORD | awk '{print $2}'`
envtype=`cat host_details.txt | grep _${mws_var}_NAME | awk '{print $2}'`
 
 #Need to source it via env variable.REMOVE HARD CODING
 custid=itmb


echo "mode: apps9" >> $TARGETFILE
echo "duration: true" >> $TARGETFILE
echo "admin_port: ${adminport}" >> $TARGETFILE
echo "domain: ${host_ip_local}" >> $TARGETFILE
echo "admin_url: http://${host_ip_local}:${adminport}/" >> $TARGETFILE
echo "url: ${fqdn}/" >> $TARGETFILE
echo "mws_monit_user: ${mws_TESTmon_user}" >> $TARGETFILE
echo "mws_monit_pass: ${mws_TESTmon_password}" >> $TARGETFILE
echo "CERTIFICATES:" >> $TARGETFILE
echo "  CERT_MWS_${custid}${envtype}: ${fqdn}" >> $TARGETFILE  
echo "LABELS:" >> $TARGETFILE
echo "  CUSTOMERCODE: ${custid}" >> $TARGETFILE
echo "  ENVIRONMENTTYPE: ${envtype}" >> $TARGETFILE
echo "  TESTVERSION: 12.1" >> $TARGETFILE
echo "  INSTANCE: ${custid}-${envtype}-mw1" >> $TARGETFILE
echo "  EXPORTER: amm" >> $TARGETFILE
echo "HTTP:" >> $TARGETFILE
echo "  CERT_MWS_${custid}${envtype}: 86400" >> $TARGETFILE
echo "MWS:" >> $TARGETFILE
echo "  USER_LOGIN: 600" >> $TARGETFILE
echo "  FNDBAS_STATUS: 600" >> $TARGETFILE
echo "  FNDBASXA_STATUS: 600" >> $TARGETFILE
echo "  FNDBAS_CURRCAPACITY: 600" >> $TARGETFILE
echo "  FNDBASXA_CURRCAPACITY: 600" >> $TARGETFILE
echo "  FNDBAS_CURRENT_COUNT: 600" >> $TARGETFILE
echo "  FNDBASXA_CURRENT_COUNT: 600" >> $TARGETFILE
echo "  FNDBAS_AVG_WAIT: 600" >> $TARGETFILE
echo "  FNDBASXA_AVG_WAIT: 600" >> $TARGETFILE
echo "  PLSQL_SWITCH_USER_PERCENTAGE: 600" >> $TARGETFILE
echo "  PLSQL_WAITED_REQUESTS_PERCENTAGE: 600" >> $TARGETFILE
echo "  STUCK_THREADS: 120" >> $TARGETFILE
echo "  HEALTHSTATEID: 60" >> $TARGETFILE
echo "  JAVA_MEMORY_USAGE: 120" >> $TARGETFILE
echo "  APPLICATIONS_STARTED: 3600" >> $TARGETFILE