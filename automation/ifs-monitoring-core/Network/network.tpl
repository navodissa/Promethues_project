
param(
  $subscription_id='${subscription_id}',
  $tenant_id='${tenant_id}',
  $client_secret='${client_secret}',
  $custcode='${custcode}',
  $client_id='${client_id}',
  $ResourceGroupName='${ResourceGroupName}',
  $TESTversion='${TESTversion}'
  
)

$ErrorActionPreference = "stop"

$SecurePassword = $client_secret | ConvertTo-SecureString -AsPlainText -Force
$Credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $client_id, $SecurePassword

Connect-AzAccount -Credential $Credential -Tenant $tenant_id -ServicePrincipal

Select-AzSubscription -SubscriptionId $subscription_id

#################### Getting VM info #######################

    $net_interfaces = Get-AzNetworkInterface -ResourceGroupName $ResourceGroupName

    $mws_nic = $intf.Name
        
    

    

$all_vms = @{'mws_vm_nic' = $mws_nic
             }

$object = [PSCustomObject]$all_vms
    $object | ConvertTo-Json
    $object | ConvertTo-Json > "net_int.ifvars.tem"
    ((Get-Content "net_int.ifvars.tem") -join "`n") + "`n" | Set-Content -NoNewline "net_int.ifvars.json"
