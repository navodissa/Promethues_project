param(

  $tenant_id = '${tenant_id}',
  $client_secret = '${client_secret}',
  $subscription_id = '${subscription_id}',
  $Resource_Group = '${Resource_Group}',
  $VM_name = '${name}',
  $client_id = '${client_id}'

)

$SecurePassword = $client_secret | ConvertTo-SecureString -AsPlainText -Force
$Credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $client_id, $SecurePassword

Connect-AzAccount -Credential $Credential -Tenant $tenant_id -ServicePrincipal
Select-AzSubscription -SubscriptionId $subscription_id

Invoke-AzVMRunCommand -ResourceGroupName $Resource_Group -VMName $VM_name -CommandId 'RunPowerShellScript' -ScriptPath 'ConfigureRemotingForAnsiblewithBasic.ps1'