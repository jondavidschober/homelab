New-Item -Path "C:\" -Name "Updates" -ItemType Directory

Write-Output "$(Get-Date -Format G): Downloading Convenience rollup update for Windows 7"
(New-Object Net.WebClient).DownloadFile("http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu", "C:\Updates\windows6.1-kb3125574-v4-x64.msu")

$kbid="windows6.1-kb3125574-v4-x64"
$update="Convenience rollup update for Windows 7"

Write-Output "$(Get-Date -Format G): Extracting $update"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\$kbid.msu /extract:C:\Updates" -Wait

Write-Output "$(Get-Date -Format G): Installing $update"
$process = (Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\$kbid.cab /quiet /norestart /LogPath:C:\Windows\Temp\$kbid.log" -PassThru)

# https://stackoverflow.com/questions/10262231/obtaining-exitcode-using-start-process-and-waitforexit-instead-of-wait#comment71507068_23797762

while ($null -eq $process.ExitCode)
{
    Write-Output "$(Get-Date -Format G): Convenience rollup update for Windows 7 is still installing (PID $($process.Id))"
    Wait-Process -Id $process.Id -Timeout 180 -ErrorAction SilentlyContinue
    $process.Refresh()
}

Write-Output "$(Get-Date -Format G): Convenience rollup update for Windows 7 exited with exit code $($process.ExitCode)"

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse
Write-Output "$(Get-Date -Format G): Finished installing $update. The VM will now reboot and continue the installation process."
