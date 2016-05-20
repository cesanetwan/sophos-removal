# v1.0
# Developed by Gareth Hill 
# Nukes Sophos

$ErrorActionPreference = 'SilentlyContinue'

foreach ($svc in Get-Service -DisplayName Sophos*) {
    Stop-Service -displayname $svc.DisplayName
}
foreach ($sophos32product in (Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object {$_.DisplayName -like "Sophos*"})) {
    if ($sophos32product -ne $null) {
        $UninstallGUID = $sophos32product.PSChildName
        Start-Process -FilePath msiexec -ArgumentList @("/uninstall $UninstallGUID", "/quiet", "/norestart") -Wait
    }
}
foreach ($sophos64product in (Get-ChildItem HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object {$_.DisplayName -like "Sophos*"})) {
    if ($sophos64product -ne $null) {
        $UninstallGUID = $sophos64product.PSChildName
        Start-Process -FilePath msiexec -ArgumentList @("/uninstall $UninstallGUID", "/quiet", "/norestart") -Wait
    }
}
