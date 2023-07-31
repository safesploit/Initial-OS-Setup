# Winget PowerShell Script

# Function to Install Packages using Winget
function Install-Package ($packageName) {
    # Check if the package is already installed
    if ((winget list --id $packageName) -like "*$packageName*") {
        Write-Host "$packageName is already installed"
    } else {
        # Install the package
        winget install --id $packageName -e
    }
}

# List of Packages to Install
$packagesToInstall = @(
    "1Password.1Password",
    "9WZDNCRD29V9", # Microsoft 365
    "Google.Chrome",
    "Microsoft.VisualStudioCode",
    "Microsoft.WindowsTerminal",
    "ProtonTechnologies.ProtonVPN",
    "qBittorrent.qBittorrent", # Unsigned
    "Spotify.Spotify",
    "VideoLAN.VLC"
    # To add more packages, just add new lines here like the above
    # "PackageName"
)

# Loop through each package and call the Install-Package function
foreach ($package in $packagesToInstall) {
    Install-Package -packageName $package
}
