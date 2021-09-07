#Invoke-WebRequest http://10.241.0.4/api/v4/projects/39/trigger/pipeline `
#    -Method 'POST' `
 #   -Body @{'-F token = 28a17ac202860ca0b3cf7f72033f38 ref = master'}
 #$NumOfRows = 25
 Import-Csv $PSScriptRoot\All_clients.csv | ForEach-Object {
    # Write-Host "$($_.Name), whose Employee ID is $($_.EmployeeID), was born on $($_.Birthday)."
    #for ($i=1;$i -lt $NumOfRows ; $i++){
 
     #  if (0 -eq $i%10){
     #     Start-Sleep -Seconds 600
    
     #  }
    
 
 
    $azure_subscription_id=$_.subscription_id
    $custcode=$_.custcode
    $TESTversion=$_.TESTversion
    $ResourceGroupName=$_.ResourceGroupName
    $Hostname=$_.Hostname
    $environmenttype=$_.environmenttype

 
 $postParams = @{
 token='d6b30e8b3d0321f99ff3e77b93590e';
 ref='Apps9_Test_Pipeline';
 "variables[TF_VAR_custcode]"="$custcode";
 "variables[TF_VAR_TESTversion]"="app9";
 "variables[TF_VAR_ResourceGroupName]"="$ResourceGroupName";
 "variables[TF_VAR_azure_subscription_id]"="$azure_subscription_id";
 "variables[TF_VAR_Hostname]"="$Hostname";
 "variables[TF_VAR_environmenttype]"="$environmenttype"


 
 }
 
 Write-Host "Customer Code is $custcode \n envrionment Type is $environmenttype"
 
 #$postParams = @{token="c6f568b7a42b6f60729ae6355a80f3";ref="master";TF_VAR_custcode= "delx" }
 Invoke-WebRequest -Uri http://10.241.0.4/api/v4/projects/61/trigger/pipeline -Method POST -Body $postParams
 
 
 
 
 
 
 
  #  }
 }
 
 
 
 