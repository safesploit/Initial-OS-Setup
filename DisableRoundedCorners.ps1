<#
    Windows 11 Script - Disable Rounded Corners

    This script disables rounded corners in Windows 11 using the Registry Editor.
    It creates a DWORD value in the Windows Registry and prompts for a restart.
#>

# Get the current user's profile directory
$userProfileDir = $env:USERPROFILE

# Backup registry
$backupPath = Join-Path -Path $userProfileDir -ChildPath "DWM_Backup.reg"
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" $backupPath

# Create and set the DWORD value
$registryPath = "HKCU:\Software\Microsoft\Windows\DWM"
$registryName = "UseWindowFrameStagingBuffer"
$registryValue = 0

New-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -PropertyType DWORD -Force

# Prompt user to restart
Write-Host "Changes have been made to the Windows Registry. A restart is necessary for the changes to take effect."
$restartChoice = Read-Host "Do you want to restart now? (Y/N)"

if ($restartChoice -eq "Y" -or $restartChoice -eq "y") {
    Restart-Computer -Force
} else {
    Write-Host "Remember to restart your computer later to apply the changes."
}
