# Construct URL
$baseURL = "https://ragnacustoms.com/songs/ddl/"
$startIndex = 3645
$endIndex = 9

# Target directory for downloaded files
$targetDirectory = "$env:USERPROFILE\Downloads\RagnarockVR-Music"

# Create target directory if it does not exist
if (-not (Test-Path $targetDirectory)) {
    New-Item -ItemType Directory -Path $targetDirectory | Out-Null
    Write-Host "Created target directory: $targetDirectory" -ForegroundColor Green
}

# Function to check if a .dat file exists in the folder
function Test-DatFile {
    param (
        [string]$folderPath
    )
    
    $datFiles = Get-ChildItem -Path $folderPath -Filter *.dat
    
    if ($datFiles.Count -gt 0) {
        return $true
    } else {
        return $false
    }
}

# Loop for file download
for ($i = $startIndex; $i -ge $endIndex; $i--) {
    # Create URL for the current index
    $currentURL = $baseURL + $i.ToString() + ".zip"
    
    # Destination path for downloaded file
    $destination = Join-Path -Path $targetDirectory -ChildPath "$i.zip"
    
    try {
        # Download file
        Invoke-WebRequest -Uri $currentURL -OutFile $destination -ErrorAction Stop
        
        # Output successful download message
        Write-Host "File $i has been successfully downloaded, saved at $destination." -ForegroundColor Green
        
        # Extract ZIP file
        $extractedFolder = Expand-Archive -Path $destination -DestinationPath $targetDirectory -Force
        
        # Clean up ZIP file after extraction
        Remove-Item $destination -Force

        # Output successful download message
        Write-Host "$destination, extracted, and cleanup completed." -ForegroundColor Green
    }
    catch {
        # Output error message if an error occurs
        Write-Host "Error processing file $($i): $($_.Exception.Message)" -ForegroundColor Red
    }
}
