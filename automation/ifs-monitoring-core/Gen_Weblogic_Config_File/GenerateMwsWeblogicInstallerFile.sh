#!/bin/bash
mws_var=$1

#grep _"$mws_var"_MS[1-9]_NAME host_details.txt | awk '{print $1}' >mws_ms_list-$mws_var
grep _"$mws_var"_MS[1-9]_NAME host_details.txt |cut -c4-12 >mws_ms_list-$mws_var

host_ip_local=`cat host_details.txt | grep address | awk '{print $2}'`
admin_server_port=`cat host_details.txt | grep _${mws_var}_ADMIN_SERVER_PORT | awk '{print $2}'`

while read -r line; do

Input="_"$line"NAME"
ServerName=`cat host_details.txt | grep $Input | awk '{print $2}'`
#TARGETFILE=wls-exporter-$mws_var-$ServerName-installer.py
TARGETFILE=PythonScripts/wls-exporter-$mws_var-$ServerName-installer.py

echo " def wlDeploy(username, password, adminURL, appName, appPath):" >> $TARGETFILE
echo "    try:" >> $TARGETFILE
echo "        connect('TEST','internal1','t3://$host_ip_local:$admin_server_port')" >> $TARGETFILE
echo "        #start edit operation" >> $TARGETFILE
echo "        edit()" >> $TARGETFILE
echo "        startEdit()" >> $TARGETFILE
echo "        progress = deploy('wls-exporter','G:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')" >> $TARGETFILE
echo "        progress.printStatus()" >> $TARGETFILE
echo "        save()" >> $TARGETFILE
echo '        activate(20000,block="true")' >> $TARGETFILE
echo "        disconnect()" >> $TARGETFILE
echo "        exit()" >> $TARGETFILE
echo "    except Exception, ex:" >> $TARGETFILE
echo "        print ex.toString()" >> $TARGETFILE
echo "        cancelEdit('y')" >> $TARGETFILE
echo "wlDeploy('TEST','internal1','t3://$host_ip_local:$admin_server_port','wls-exporter','G:/wls-exporter/wls-exporter.war')" >> $TARGETFILE

done < mws_ms_list-$mws_var



