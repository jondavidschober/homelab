if ($env:PACKER_BUILDER_TYPE -And $($env:PACKER_BUILDER_TYPE).startsWith("hyperv")) {
  Write-Output Skip debloat steps in Hyper-V build.
}
else {
  Write-Output Downloading debloat zip
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $url = "https://github.com/Sycnex/Windows10Debloater/archive/master.zip"
  (New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
  Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force
  Set-ExecutionPolicy Unrestricted -Force
  . $env:TEMP\Windows10Debloater-master\Windows10SysPrepDebloater.ps1 -Debloat -Privacy

  Remove-Item $env:TEMP\debloat.zip
  Remove-Item -recurse $env:TEMP\Windows10Debloater-master
}


# if ($env:PACKER_BUILDER_TYPE -And $($env:PACKER_BUILDER_TYPE).startsWith("hyperv")) {
#   Write-Output Skip debloat steps in Hyper-V build.
# }
# else {
#   Write-Output Downloading debloat zip
#   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#   $url = "https://github.com/W4RH4WK/Debloat-Windows-10/archive/master.zip"
#   (New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
#   Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force

#   Write-Output Block telemetry
#   . $env:TEMP\Debloat-Windows-10-master\scripts\block-telemetry.ps1
#   # Write-Output Disable Windows Defender
#   # if ($(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName.StartsWith("Windows 10")) {
#   #   . $env:TEMP\Debloat-Windows-10-master\scripts\disable-windows-defender.ps1
#   # }
#   # else {
#   #   Uninstall-WindowsFeature Windows-Defender
#   # }
#   Write-Output Optimize Windows Update
#   . $env:TEMP\Debloat-Windows-10-master\scripts\optimize-windows-update.ps1
#   #Write-Output Disable Windows Update
#   #Set-Service wuauserv -StartupType Disabled
#   Write-Output Remove OneDrive
#   . $env:TEMP\Debloat-Windows-10-master\scripts\remove-onedrive.ps1


# Write-Output Remove Apps
#   . $env:TEMP\Debloat-Windows-10-master\scripts\remove-default-apps.ps1

#   Remove-Item $env:TEMP\debloat.zip
#   Remove-Item -recurse $env:TEMP\Debloat-Windows-10-master
# }
