# Set variables
param (
    [string]$serverPort = "18080", # The port which the service runs on and metrics gets available on.
    [string]$mssql_version = "", # Optional - Only used in description of service. 
    [string]$serviceName = "sql_exporter", # This should not be changed because of prometheus alert rules.
    [string]$folder = "c:\TESTmon", # The root installation folder of the service itself
    [switch]$update = $false, # Flag used to force reinstall of service.
	[switch]$delete = $false, # Flag used to delete service.
	[switch]$install = $true, # Flag used to install service.
    [string]$db_hostname = "localhost", # Database host name, (server name)
    [string]$db_instance = "master", # Database instance
    [string]$sql_port = "1433" # 1433 is the standard sql port, can vary if changed during sql installation.
)
# This is the folder name of the mssql exporter itself (from the extraction). So this needs to be the same as that folder name.
# This probably shouldn't be changed.
$folderName = "mssql_exporter" 

# Save starting folder so we can navigate back after script is finished.
$startingFolder = Get-Location

# Create root folder (In case it doesn't allready exist, so location change works to check / delete service if needed).
New-Item -path "$folder\" -type directory -Force | Out-Null

# Change location. So we can delete service if necessary.
Set-Location "$folder"

# If -delete flag is set, we delete service and remove binarys then break script.
If($delete) 
{
	# Check if the service is already installed, if not we throw error message.
	If (!(Get-Service $serviceName -ErrorAction SilentlyContinue)) 
	{
		Write-Warning "No service is installed. Use -install flag to install service."
		
		# Navigate back to starting folder before script breaks.
		Set-Location "$startingFolder"
        Break Script
	}
	# Stop service
	If ((Get-Service $serviceName).Status -eq 'Running') 
	{
		.\nssm\win64\nssm.exe stop $serviceName
	}
	
	# Delete current version of the service.
	.\nssm\win64\nssm.exe remove $serviceName confirm
	
	# Remove old binaries
	Remove-Item -Path "$folder\$folderName" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$folder\nssm" -Recurse -Force -ErrorAction SilentlyContinue

	# Navigate back to starting folder.
	Set-Location "$startingFolder"
	# Delete is done, break script.
	Break Script
}

# Check if the service is already installed, exit if not update flag provided.
If (Get-Service $serviceName -ErrorAction SilentlyContinue) 
{
	# If service exists and -update isn't set. Throw a warning and break script.
    If(!$update) 
	{
        $displayName = (Get-Service -Name $serviceName).displayName
        Write-Warning "$displayname already installed. If you want to reinstall provide the '-update' flag."
		
		# Navigate back to starting folder before script breaks.
		Set-Location "$startingFolder"
        Break Script

    }
	# Stop service
    If ((Get-Service $serviceName).Status -eq 'Running') 
	{
        .\nssm\win64\nssm.exe stop $serviceName
    }

    # Uninstall current version of the service
    .\nssm\win64\nssm.exe remove $serviceName confirm
}

# Either update or install flag needs to be set to continue.
If($update -Or $install)
{
	# Remove old binaries
	Remove-Item -Path "$folder\$folderName" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$folder\nssm" -Recurse -Force -ErrorAction SilentlyContinue

	# Navigate back to starting folder.
	Set-Location "$startingFolder"

	# Create root folder (since we deleted old binarys).
	New-Item -path "$folder\" -type directory -Force | Out-Null

	# Copy Mssql folder + files
	Copy-Item "$folderName" -Destination "$folder\$folderName" -Recurse -Force

	# Prerequisits
	Copy-Item -Path "nssm" -Destination "$folder\" -Force -Recurse -ErrorAction SilentlyContinue

	# Change location (cd - change directory). This is because we later on use current directory for installing nssm service.
	Set-Location "$folder"

	# Install service using nssm.
	.\nssm\win64\nssm.exe install $serviceName "$folder\$folderName\mssql_exporter.exe" "serve -ServerPort $serverPort -ServerPath /metrics -AddExporterMetrics False -ConfigFile ""$folder\$folderName\metrics.json"" -DataSource ""Server=tcp:$db_hostname\$db_instance,$sql_port;Initial Catalog=DELTA_TEST_DEV;Persist Security Info=False;Integrated Security=True;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Connection Timeout=20;"""
	.\nssm\win64\nssm.exe set $serviceName Description "Mssql Exporter ($mssql_version)"
	.\nssm\win64\nssm.exe set $serviceName AppStdout $folder\$folderName\mssql_exporter_service.log
	.\nssm\win64\nssm.exe set $serviceName AppStderr $folder\$folderName\mssql_exporter_service.log

	# Start service
	Start-Sleep 10
	.\nssm\win64\nssm.exe start $serviceName

	# Navigate back to starting folder.
	Set-Location "$startingFolder"
}
Else
{
	Write-Warning "No flag was set. Available options are:"
	Write-Warning "-install -update -delete"
	Write-Warning "IMPORTANT! Only support for one flag at a time."
	
	# Navigate back to starting folder before script breaks.
	Set-Location "$startingFolder"
	Break Script
}
