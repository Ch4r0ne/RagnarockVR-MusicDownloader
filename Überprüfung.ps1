# Funktion zur Überprüfung, ob eine *.dat direkt im Ordner vorhanden ist
function Test-DataFileInFolder {
    param (
        [string]$folderPath
    )
    
    $datFiles = Get-ChildItem -Path $folderPath -Filter "*.dat"
    
    if ($datFiles.Count -gt 0) {
        return $true
    } else {
        return $false
    }
}

# Zielverzeichnis, das überprüft werden soll
$targetDirectory = "C:\Users\leini\Downloads\Musik2"

# Alle Unterverzeichnisse im Zielverzeichnis abrufen und überprüfen
$subfolders = Get-ChildItem -Path $targetDirectory -Directory

foreach ($subfolder in $subfolders) {
    if (Test-DataFileInFolder -folderPath $subfolder.FullName) {
        Write-Host "In $subfolder ist eine *.dat direkt vorhanden." -ForegroundColor Green
    } else {
        Write-Host "In $subfolder ist keine *.dat direkt vorhanden." -ForegroundColor Red
    }
}
