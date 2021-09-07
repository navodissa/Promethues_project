

cd E:\TEST\${custcode}${environmenttype}\MWS\instance\${custcode}${environmenttype}

$ConfigXMLPath = "E:\TEST\${custcode}${environmenttype}\MWS\instance\${custcode}${environmenttype}\${custcode}${environmenttype}_configuration.xml"
[xml]$ConfigFile = Get-Content $ConfigXMLPath -Raw

$adminserverport = $ConfigFile.installtool.configure.clusterconfig.'TEST.fndmws.admin.server.port'
$nodemanagerport = $ConfigFile.installtool.configure.clusterconfig.'TEST.fndmws.nodemanager.port'
$managedserverport = $ConfigFile.installtool.configure.clusterconfig.'TEST.fndmws.managed.server.port'
$managedserver2port = $ConfigFile.installtool.configure.clusterconfig.'TEST.fndmws.managed.server2.port'
$fqdn = $ConfigFile.installtool.configure.apache.'TEST.system.url'



$all_infor = @{ 'Adminserverport' = $adminserverport;'Nodemanagerport' = $nodemanagerport; 'Managedserverport' = $managedserverport; 'Managedserver2port' = $managedserver2port; 'FQDN' = $fqdn
             }

$object = [PSCustomObject]$all_infor
    $object | ConvertTo-Json
    $object | ConvertTo-Json > "install_xml_output.tem"
    ((Get-Content "install_xml_output.tem") -join "`n") + "`n" | Set-Content -NoNewline "install_xml_output.json"

# read Config XML ConfigFile

[xml]$XmlDocument = Get-Content -Path 'E:\TEST\${custcode}${environmenttype}\MWS\wls_domain\${custcode}${environmenttype}\config\config.xml'
$XmlDocument.GetType().FullName > $null
$XmlDocument.domain.server.name > $null

Remove-Item "E:\Scripts\*target*.yml"
Clear-Content "E:\Scripts\${custcode}_${environmenttype}_target.yml"

$ArryNum=$XmlDocument.domain.server.name.Length


for ($i=0; $i -le $ArryNum-1; $i++)
{
	$ServerName=$XmlDocument.domain.server.name[$i]
	if ( $ServerName -eq 'AdminServer')
	{
	
	$AdminPort=$XmlDocument.domain.server.'listen-port'[$i]
	$AdminServerName=$ServerName
	
	echo " - targets: ['`${host_ip_local}`:$AdminPort']
   labels:
      instance: '`${hostname}`'
      name: 'mws_admin_server'
      port: '$AdminPort'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	
	}
	elseif ( $ServerName -eq 'MainServer1')
	{
	
	$ManagedServer01Port=$XmlDocument.domain.server.'listen-port'[$i]
	$ManagedServer01Name=$ServerName
	
	echo " - targets: ['`${host_ip_local}`:$ManagedServer01Port']
   labels:
      instance: '`${hostname}`'
      name: 'managed_server_01'
      port: $ManagedServer01Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	
	}
	elseif ( $ServerName -eq 'IntServer1')
	
	{
	$IntServer01Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer01Name=$ServerName
	
	echo " - targets: ['`${host_ip_local}`:$IntServer01Port']
   labels:
      instance: '`${hostname}`'
      name: 'inventry_server_01'
      port: '$IntServer01Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	elseif ( $ServerName -eq 'MainServer2')
	{
	$ManagedServer02Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer02Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$ManagedServer02Port']
   labels:
      instance: '`${hostname}`'
      name: 'managed_server_02'
      port: '$ManagedServer02Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	
	elseif ( $ServerName -eq 'IntServer2')
	{
	$IntServer02Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer02Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$IntServer02Port']
   labels:
      instance: '`${hostname}`'
      name: 'inventry_server 02'
      port: '$IntServer02Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	
	elseif ( $ServerName -eq 'MainServer3')
	{
	$ManagedServer03Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer03Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$ManagedServer03Port']
   labels:
      instance: '`${hostname}`'
      name: 'managed_server_03'
      port: '$ManagedServer03Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	
	elseif ( $ServerName -eq 'IntServer3')
	{
	$IntServer03Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer03Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$IntServer03Port']
   labels:
      instance: '`${hostname}`'
      name: 'inventry_server_03'
      port: '$IntServer03Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	
	elseif ( $ServerName -eq 'MainServer4')
	{
	$ManagedServer04Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer04Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$ManagedServer04Port']
   labels:
      instance: '`${hostname}`'
      name: 'managed_server_04'
      port: '$ManagedServer04Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	}
	
	elseif ( $ServerName -eq 'IntServer4')
	{
	$IntServer04Port=$XmlDocument.domain.server.'listen-port'[$i]
    $IntServer02Name=$ServerName	
	
	echo " - targets: ['`${host_ip_local}`:$IntServer04Port']
   labels:
      instance: '`${hostname}`'
      name: 'inventry_server_04'
      port: '$IntServer04Port'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
		
	}
	
	
 
	
}

echo " - targets: ['`${host_ip_local}`:$Nodemanagerport']
   labels:
      instance: '`${hostname}`'
      name: 'mws_node_manager'
      port: '$Nodemanagerport'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
	
	
	  
echo " - targets: ['`${host_ip_local}`:48080']
   labels:
      instance: '`${hostname}`'
      name: 'mws_ohs_http'
      port: '48080'
      customercode: '`${custcode}`'
      environmenttype: '`${environmenttype}`'
      region: '`${region}`' " | Out-File -FilePath 'E:\Scripts\${custcode}_${environmenttype}_target.yml' -Append
  
	  
	  
	 
	  



Copy-Item "E:\TEST\custcode${environmenttype}\MWS\instance\custcode${environmenttype}\install_xml_output.json" -Destination "E:\Scripts"
