# v1.1
# Developed by Gareth Hill 
# Nukes Sophos

$ErrorActionPreference = 'SilentlyContinue'

foreach ($svc in Get-Service -DisplayName Sophos*) {
    Stop-Service -displayname $svc.DisplayName
}
Stop-Process -processname ALMon -force
Stop-Process -processname ManagementAgentNT -force
Stop-Process -processname SavService -force
Stop-Process -processname SAVAdminService -force
Stop-Process -processname Alsvc -force
Stop-Process -processname CertificationManagerServiceNT -force
Stop-Process -processname Sophos.FrontEnd.Service -force
Stop-Process -processname MgntSvc -force
Stop-Process -processname RouterNT -force
Stop-Process -processname PatchEndpointCommunicator -force
Stop-Process -processname PatchEndpointOrchestrator -force
Stop-Process -processname PatchServerCommunicator -force
Stop-Process -processname ssp -force
Stop-Process -processname SUMService -force
Stop-Process -processname swc_service -force
Stop-Process -processname swi_filter -force
Stop-Process -processname swi_service -force
Stop-Process -processname SntpService -force
Stop-Process -processname EnterpriseConsole -force
Stop-Process -processname Sophos.Messenger -force
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
foreach ($svc in Get-Service -DisplayName Sophos*) {
    sc.exe delete $svc.Name
}
Remove-Item "C:\Program Files (x86)\Sophos" -Force  -Recurse -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\Common Files\Sophos" -Force  -Recurse -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files\Sophos" -Force  -Recurse -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files\Common Files\Sophos" -Force  -Recurse -ErrorAction SilentlyContinue
Remove-Item "C:\ProgramData\Sophos" -Force  -Recurse -ErrorAction SilentlyContinue
