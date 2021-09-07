$text = Get-Content -Path TESTapp-amm.ifm
$instance= $text[1].Split("=")[1]
Write-Host "The TEST AMM EXPORTER($instance) service is restarting."
Restart-Service -name "TEST_AMM($instance)"
Write-Host "The TEST AMM EXPORTER($instance) service was restarted successfully."
pause
