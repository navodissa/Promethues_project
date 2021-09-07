
az login --service-principal -u $3 -p $4 --tenant $5
pass123=$(az keyvault secret show --name $2 --vault-name $1 --query value -o tsv)
echo $pass123

sed -i "s/#password#/$pass123/g" config.yaml

