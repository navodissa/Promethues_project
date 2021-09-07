$text = Get-Content -Path TESTapp-amm.ifm
$instance= $text[1].Split("=")[1]
.\TESTsrv -remove "TEST_AMM($instance)"
pause