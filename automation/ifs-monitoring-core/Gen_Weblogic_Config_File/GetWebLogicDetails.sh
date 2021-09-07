 
 #!/bin/bash
 
 hostname=$1


 rm -rf host_details.txt mws_list

 #awk -vRS='' '/'$hostname'/{print}' hosts.txt >> host_details.txt
 awk -vRS='' '/'$hostname'/{print}' hosts_tst.txt > host_details.txt
  grep _MWS[1-9]_NAME host_details.txt |cut -c4-7 >mws_list

#rm -f *.py
rm -rf PythonScripts
mkdir PythonScripts

while read -r line; do
sh GenerateMwsWeblogicInstallerFile.sh $line
done < mws_list


rm -rf mws_list host_details.txt mws_ms_list-*
