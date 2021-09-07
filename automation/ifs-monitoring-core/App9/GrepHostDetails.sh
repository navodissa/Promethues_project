 
 #!/bin/bash
 
 hostname=$1

 rm -rf Appip.json host_details.txt
 awk -vRS='' '/'$hostname'/{print}' hosts.txt >> host_details.txt
 #awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt >> host_details.txt

 Apphost_IP=`cat host_details.txt | grep address | awk '{print $2}'`

 echo "{ \"Apphost_ip\" : \"$Apphost_IP\" }" > Appip.json