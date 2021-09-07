#!/bin/bash


server_location=$1

if [[ $server_location == "US" ]]
then

#azcopy copy "*target.yml" "https://cscmontstussa.file.core.windows.net/configfileshare/Apps9/Blackbox_Configs/?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-12-31T22:28:56Z&st=2021-01-14T14:28:56Z&spr=https&sig=eHc5RSI89VMW34rgLOTnYqPofLjU%2B8h54V9UWF5aTXE%3D"

azcopy copy "config_TESTversion_APPS9_Central*.yaml" "https://cscmontstussa.file.core.windows.net/configfileshare/Apps9/AMM_Configs_Central/?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-12-31T22:28:56Z&st=2021-01-14T14:28:56Z&spr=https&sig=eHc5RSI89VMW34rgLOTnYqPofLjU%2B8h54V9UWF5aTXE%3D"

elif [[ $server_location == "EU" ]]
then

#azcopy copy "*target.yml" "https://cscmontmpeusa.file.core.windows.net/configfileshare/Apps9/Blackbox_Configs/?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2022-01-08T16:06:07Z&st=2021-01-08T08:06:07Z&spr=https&sig=uLRQRvmy%2BXJdvLo4LMdJLfdNyENqkBMLax%2B38XpAXlA%3D"

azcopy copy "config_TESTversion_APPS9_Central*.yaml" "https://cscmontmpeusa.file.core.windows.net/configfileshare/Apps9/AMM_Configs_Central/?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2022-01-08T16:06:07Z&st=2021-01-08T08:06:07Z&spr=https&sig=uLRQRvmy%2BXJdvLo4LMdJLfdNyENqkBMLax%2B38XpAXlA%3D"

else

echo "not able to find a correct location"

fi