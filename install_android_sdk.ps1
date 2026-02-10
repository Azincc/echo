# Set variables
$AndroidHome = "D:\Android"
$CmdLineToolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
$ZipPath = "$AndroidHome\commandlinetools.zip"
$ExtractPath = "$AndroidHome\temp_extract"
$FinalCmdLineToolsPath = "$AndroidHome\cmdline-tools\latest"

# 1. Create directory
if (-not (Test-Path $AndroidHome)) {
    New-Item -ItemType Directory -Force -Path $AndroidHome
    Write-Host "Created Android Home directory: $AndroidHome"
}

# 2. Download Command Line Tools
if (-not (Test-Path $ZipPath)) {
    Write-Host "Downloading Android Command Line Tools..."
    Invoke-WebRequest -Uri $CmdLineToolsUrl -OutFile $ZipPath
    Write-Host "Download complete."
}

# 3. Extract and Configure Structure
if (-not (Test-Path $FinalCmdLineToolsPath)) {
    Write-Host "Extracting..."
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractPath -Force
    
    # Structure fix: Move content to cmdline-tools/latest
    # The zip usually contains a 'cmdline-tools' folder at root
    $Source = "$ExtractPath\cmdline-tools"
    
    New-Item -ItemType Directory -Force -Path "$AndroidHome\cmdline-tools"
    
    # Move the inner content to 'latest'
    Move-Item -Path $Source -Destination $FinalCmdLineToolsPath
    
    # Cleanup
    Remove-Item -Path $ExtractPath -Recurse -Force
    Remove-Item -Path $ZipPath -Force
    Write-Host "Extraction and setup complete."
}

# 4. Set Environment Variables (User Level)
Write-Host "Setting Environment Variables..."
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $AndroidHome, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $AndroidHome, [System.EnvironmentVariableTarget]::User)

# Update Path
$CurrentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
$NewPaths = @(
    "$AndroidHome\cmdline-tools\latest\bin",
    "$AndroidHome\platform-tools"
)

foreach ($p in $NewPaths) {
    if ($CurrentPath -notlike "*$p*") {
        $CurrentPath = "$CurrentPath;$p"
    }
}

[System.Environment]::SetEnvironmentVariable("Path", $CurrentPath, [System.EnvironmentVariableTarget]::User)
Write-Host "Environment variables updated. You may need to restart your terminal."

# 5. Install Packages
$SdkManager = "$FinalCmdLineToolsPath\bin\sdkmanager.bat"

if (Test-Path $SdkManager) {
    Write-Host "Accepting Licenses..."
    # Piping 'y' to sdkmanager to accept licenses
    & cmd /c "echo y | $SdkManager --licenses"
    
    Write-Host "Installing Platform Tools and Android 34..."
    & $SdkManager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
} else {
    Write-Error "sdkmanager not found at $SdkManager"
}

Write-Host "Installation Finished!"
