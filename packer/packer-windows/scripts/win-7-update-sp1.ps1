# First check if Service Pack 1 is installed.
$os = Get-CimInstance -class Win32_OperatingSystem
if ($os.ServicePackMajorVersion -ge 1) {
  Write-Output "Windows 7 Service Pack 1 is already installed."
  Exit
}

New-Item -Path "C:\" -Name "Updates" -ItemType Directory

# Service Pack 1 is an absolute requirement. Installing updates from Windows Update
# will fail if SP1 is not installed.
Write-Output "$(Get-Date -Format G): Downloading and installing Windows 7 Service Pack 1."
Write-Output "$(Get-Date -Format G): This process can take up to 30 minutes."

Write-Output "$(Get-Date -Format G): Downloading Windows 7 Service Pack 1"
(New-Object Net.WebClient).DownloadFile("http://download.windowsupdate.com/msdownload/update/software/svpk/2011/02/windows6.1-kb976932-x64_74865ef2562006e51d7f9333b4a8d45b7a749dab.exe", "C:\Updates\windows6.1-KB976932-X64.exe")

Write-Output "$(Get-Date -Format G): Installing Windows 7 Service Pack 1"
$process = (Start-Process -FilePath "C:\Updates\Windows6.1-KB976932-X64.exe" -ArgumentList "/unattend /nodialog /norestart" -PassThru)

# https://stackoverflow.com/questions/10262231/obtaining-exitcode-using-start-process-and-waitforexit-instead-of-wait#comment71507068_23797762

while ($null -eq $process.ExitCode) {
  Write-Output "$(Get-Date -Format G): Windows 7 Service Pack 1 is still installing (PID $($process.Id))"
  Wait-Process -Id $process.Id -Timeout 180 -ErrorAction SilentlyContinue
  $process.Refresh()
}

Write-Output "$(Get-Date -Format G): Windows 7 Service Pack 1 exited with exit code $($process.ExitCode)"

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse

Write-Output "$(Get-Date -Format G): Finished installing Windows 7 Service Pack 1. The VM will now reboot and continue the installation process."
Write-Output "$(Get-Date -Format G): This may take a couple of minutes."
