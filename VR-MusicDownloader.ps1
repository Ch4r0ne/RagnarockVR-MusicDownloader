# URL zusammensetzen
$baseURL = "https://ragnacustoms.com/songs/ddl/"
$startIndex = 3645
$endIndex = 9

# Zielverzeichnis für die heruntergeladenen Dateien
$targetDirectory = "C:\Users\leini\Downloads\temp1"

# Funktion zur Überprüfung, ob eine .dat-Datei im Ordner vorhanden ist
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

# Schleife für den Dateidownload
for ($i = $startIndex; $i -ge $endIndex; $i--) {
    # URL für den aktuellen Index erstellen
    $currentURL = $baseURL + $i.ToString() + ".zip"
    
    # Ziel-Pfad für die heruntergeladene Datei
    $destination = Join-Path -Path $targetDirectory -ChildPath "$i.zip"
    
    try {
        # Datei herunterladen
        Invoke-WebRequest -Uri $currentURL -OutFile $destination -ErrorAction Stop
        
        # Ausgabe, dass der Download erfolgreich war
        Write-Host "Download von Datei $i erfolgreich abgeschlossen. Datei wurde unter $destination gespeichert."
        
        # ZIP-Datei extrahieren
        $extractedFolder = Expand-Archive -Path $destination -DestinationPath $targetDirectory -Force
        
        # Überprüfen, ob eine .dat-Datei im extrahierten Ordner vorhanden ist
        if (Test-DatFile -folderPath $extractedFolder) {
            Write-Host "Korrekte Datei gefunden im Ordner: $extractedFolder"
        } else {
            Write-Host "Keine korrekte Datei gefunden im Ordner: $extractedFolder"
            
            # Falls eine .dat-Datei nicht gefunden wurde, kopiere den Inhalt des Ordners auf die oberste Ebene
            $subfolders = Get-ChildItem -Path $extractedFolder -Directory
            foreach ($subfolder in $subfolders) {
                $subfolderFiles = Get-ChildItem -Path $subfolder.FullName -Recurse
                
                foreach ($file in $subfolderFiles) {
                    $newFilePath = Join-Path -Path $targetDirectory -ChildPath $file.Name
                    Move-Item -Path $file.FullName -Destination $newFilePath -Force
                }
            }
            
            # Bereinigen des leeren Ordners
            Remove-Item -Path $extractedFolder -Recurse -Force
        }
        
        # Bereinigen der ZIP-Datei nach dem Extrahieren
        Remove-Item $destination -Force
    }
    catch {
        # Ausgabe, falls ein Fehler auftritt
        Write-Host "Fehler beim Verarbeiten von Datei $($i): $($_.Exception.Message)"
    }
}
