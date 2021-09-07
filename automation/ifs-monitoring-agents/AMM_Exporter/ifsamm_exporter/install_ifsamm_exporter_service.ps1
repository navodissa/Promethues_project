.\TESTsrv -install TESTapp-amm.ifm
$text = Get-Content -Path TESTapp-amm.ifm
$instance= $text[1].Split("=")[1]
Write-Host "The TEST AMM EXPORTER($instance) service is starting."
Start-Service -name "TEST_AMM($instance)"
Write-Host "The TEST AMM EXPORTER($instance) service was started successfully."
pause
