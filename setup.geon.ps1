$sourceEnvDir = "$HOME\playground\environment"
$gitconfigSource = "$sourceEnvDir\linux-environment\.gitconfig"
$gitconfigSecret = "$sourceEnvDir\linux-environment\.gitconfig.secret"
$gitconfigDest = "$HOME\.gitconfig"

$profileSource = "$sourceEnvDir\Profile.ps1"
$profileDest = $PROFILE.CurrentUserAllHosts

# Function to prepend content to a file
function Prepend-FileContent {
    param (
        [string]$sourceFile,
        [string]$destinationFile
    )
    if (Test-Path $sourceFile) {
        $tempFile = "$destinationFile.tmp"
        Get-Content $sourceFile | Set-Content $tempFile
        if (Test-Path $destinationFile) {
            Get-Content $destinationFile | Add-Content $tempFile
        }
        Move-Item -Force -Path $tempFile -Destination $destinationFile
        Write-Host "Prepended content from $sourceFile to $destinationFile"
    } else {
        Write-Host "Source file not found: $sourceFile"
    }
}

# Prepend .gitconfig.secret to .gitconfig
if (Test-Path $gitconfigSecret) {
    Prepend-FileContent -sourceFile $gitconfigSecret -destinationFile $gitconfigDest
} else {
    Write-Host "Source .gitconfig.secret not found at $gitconfigSecret"
}

# Copy Profile.ps1
if (Test-Path $profileSource) {
    Copy-Item -Path $profileSource -Destination $profileDest -Force
    Write-Host "Copied Profile.ps1 to $profileDest"
} else {
    Write-Host "Source Profile.ps1 not found at $profileSource"
}
