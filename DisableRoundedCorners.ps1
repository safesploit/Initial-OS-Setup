<#
    Windows 11 Script - Disable Rounded Corners

    This script disables rounded corners in Windows 11 using the Registry Editor.
    It creates a DWORD value in the Windows Registry and prompts for a restart.

    Note: Use this script at your own risk. Editing the Windows Registry can have
    unintended consequences if not done correctly.

    Author: safesploit
#>

# Function to check if the script is running with admin privileges
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    return $isAdmin
}

# Check if the script is running with admin privileges
if (-not (Test-Admin)) {
    Write-Host "This script requires administrator privileges to modify the Registry."
    Write-Host "Please run the script as an administrator."
    Pause
    Exit
}

# Get the current user's profile directory
$userProfileDir = $env:USERPROFILE

# Define backup file path
$backupPath = Join-Path -Path $userProfileDir -ChildPath "DWM_Backup.reg"

# Check if backup file already exists and delete it if needed
if (Test-Path $backupPath) {
    $deleteChoice = Read-Host "A backup file already exists. Do you want to delete the existing backup file? (Y/N)"
    if ($deleteChoice -eq "Y" -or $deleteChoice -eq "y") {
        Remove-Item $backupPath -Force
        Write-Host "Existing backup file deleted."
    } else {
        Write-Host "Backup will not be overwritten. Exiting script."
        Exit
    }
}

# Backup registry
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" $backupPath
Write-Host "Backup has been made and saved to: $backupPath"

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
