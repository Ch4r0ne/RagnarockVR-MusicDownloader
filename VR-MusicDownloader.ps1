# URL zusammensetzen
$baseURL = "https://ragnacustoms.com/songs/ddl/"
$startIndex = 3600
$endIndex = 9

# Zielverzeichnis für die heruntergeladenen Dateien
$targetDirectory = "C:\Users\leini\Downloads"

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
    }
    catch {
        # Ausgabe, falls ein Fehler auftritt
        Write-Host "Fehler beim Download von Datei $i."
    }
}
