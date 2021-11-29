[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://www.tightvnc.com/download/2.8.63/tightvnc-2.8.63-gpl-setup-64bit.msi"
(New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\tightvnc.msi")

msiexec /i $env:TEMP\tightvnc.msi /quiet /norestart SERVER_REGISTER_AS_SERVICE=1 SERVER_ADD_FIREWALL_EXCEPTION=1  VIEWER_ADD_FIREWALL_EXCEPTION=1 SET_USECONTROLAUTHENTICATION=1 VALUE_OF_USECONTROLAUTHENTICATION=1 SET_CONTROLPASSWORD=1 VALUE_OF_CONTROLPASSWORD=alpine SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=alpine

Remove-Item $env:TEMP\tightvnc.msi
