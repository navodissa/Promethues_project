#!/bin/bash


 mws_var=$1

 TARGETFILE=config_TESTversion_APPS9_Central_$mws_var.yaml

 
 #awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt > host_details.txt

 #Apphost_IP=`cat host_details.txt | grep address | awk '{print $2}'`
 fqdn=`cat host_details.txt | grep ${mws_var}_APPS_FQDN | awk '{print $2}'`
 mws_TESTmonitoring_user=`cat host_details.txt | grep _${mws_var}_APPS_MONITOR_USER | awk '{print $2}'`
 mws_TESTmonitoring_password=`cat host_details.txt | grep _${mws_var}_APPS_MONITOR_PASSWORD | awk '{print $2}'`
 envtype=`cat host_details.txt | grep _${mws_var}_NAME | awk '{print $2}'`
 
 #Need to source it via env variable.REMOVE HARD CODING
 custid=itmb


echo  "mode: apps9" >> $TARGETFILE
echo  "duration: true" >> $TARGETFILE
echo  "url: ${fqdn}/" >> $TARGETFILE
echo  "TEST_user: ${mws_TESTmonitoring_user}" >> $TARGETFILE
echo  "TEST_pass: ${mws_TESTmonitoring_password}" >> $TARGETFILE
echo  "URLS:" >> $TARGETFILE
echo  "  RESPONSE_MWS_MAIN: ${fqdn}/main/TESTapplications/web/favicon.ico" >> $TARGETFILE
echo  "  RESPONSE_MWS_B2B10: ${fqdn}/b2b/TESTapplications/web/favicon.ico" >> $TARGETFILE
echo  "CERTIFICATES:" >> $TARGETFILE
echo  "  CERT_MWS_${custid}${envtype}: ${fqdn}" >> $TARGETFILE
echo  "LABELS:" >> $TARGETFILE
echo  "  CUSTOMERCODE: ${custid}" >> $TARGETFILE
echo  "  ENVIRONMENTTYPE: ${envtype}" >> $TARGETFILE
echo  "  TESTVERSION: 12.1" >> $TARGETFILE
echo  "  INSTANCE: ${custid}-${envtype}-mw1" >> $TARGETFILE
echo  "  EXPORTER: amm-central" >> $TARGETFILE
echo  "HTTP:" >> $TARGETFILE
echo  "  LOGIN: 120" >> $TARGETFILE
echo  "  CERT_MWS_${custid}${envtype}: 86400" >> $TARGETFILE
echo  "  RESPONSE_MWS_B2B10: 120" >> $TARGETFILE
echo  "  RESPONSE_MWS_MAIN: 120" >> $TARGETFILE