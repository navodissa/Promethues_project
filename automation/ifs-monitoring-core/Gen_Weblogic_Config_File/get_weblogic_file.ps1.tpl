#################################################################################

# read Config XML ConfigFile

[xml]$XmlDocument = Get-Content -Path 'E:\TEST\${custcode}${environmenttype}\MWS\wls_domain\${custcode}${environmenttype}\config\config.xml'
$XmlDocument.GetType().FullName > $null
$XmlDocument.domain.server.name > $null

Remove-Item "E:\wls-exporter\wls-exporter*.py"


$ArryNum=$XmlDocument.domain.server.name.Length


for ($i=0; $i -le $ArryNum-1; $i++)
{
	$ServerName=$XmlDocument.domain.server.name[$i]
	if ( $ServerName -eq 'AdminServer')
	{
	
	$AdminPort=$XmlDocument.domain.server.'listen-port'[$i]
	$AdminServerName=$ServerName
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	
	}
	elseif ( $ServerName -eq 'MainServer1')
	{
	
	$ManagedServer01Port=$XmlDocument.domain.server.'listen-port'[$i]
	$ManagedServer01Name=$ServerName
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	
	}
	elseif ( $ServerName -eq 'IntServer1')
	
	{
	$IntServer01Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer01Name=$ServerName
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	elseif ( $ServerName -eq 'MainServer2')
	{
	$ManagedServer02Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer02Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	
	elseif ( $ServerName -eq 'IntServer2')
	{
	$IntServer02Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer02Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	
	elseif ( $ServerName -eq 'MainServer3')
	{
	$ManagedServer03Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer03Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	
	elseif ( $ServerName -eq 'IntServer3')
	{
	$IntServer03Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$IntServer03Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	
	elseif ( $ServerName -eq 'MainServer4')
	{
	$ManagedServer04Port=$XmlDocument.domain.server.'listen-port'[$i]	
	$ManagedServer04Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
	}
	
	elseif ( $ServerName -eq 'IntServer4')
	{
	$IntServer04Port=$XmlDocument.domain.server.'listen-port'[$i]
    $IntServer02Name=$ServerName	
	
	echo " def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='$ServerName',upload='true')
        progress.printStatus()
        save()
        activate(20000,block=`"true`")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','`${mws_TEST_password}`','t3://`${host_ip_local}`:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')" | Out-File -FilePath "E:\wls-exporter\wls-exporter-$ServerName-installer.py" -Append

$MyPath="E:\wls-exporter\wls-exporter-$ServerName-installer.py"

$MyRawString = Get-Content -Raw $MyPath
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
		
	}
	
	
 
	
}
