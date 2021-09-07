 
 #!/bin/bash
 
 hostname=$1

 rm -rf app9ip.json host_details.txt
 awk -vRS='' '/'$hostname'/{print}' hosts.txt >> host_details.txt
 #awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt >> host_details.txt

 App9host_IP=`cat host_details.txt | grep address | awk '{print $2}'`

 echo "{ \"App9host_ip\" : \"$App9host_IP\" }" > app9ip.json