 
 #!/bin/bash
 
 hostname=$1


 rm -rf host_details.txt mws_list

 #awk -vRS='' '/'$hostname'/{print}' hosts.txt >> host_details.txt
 awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt > host_details.txt
  grep _MWS[1-9]_NAME host_details.txt |cut -c4-7 >mws_list

rm -rf config_TESTversion_APPS9_MWS_*.yaml config_TESTversion_APPS9_Central_*.yaml

while read -r line; do
sh GenerateMwsCentralAMMConfigFile.sh $line
sh GenerateMwsAMMConfigFile.sh $line
#sh GenerateMwsWeblogicInstallerFile.sh $line
done < mws_list


rm -rf mws_list host_details.txt
