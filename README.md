# RagnarockVR-MusicDownloader

A PowerShell script for automated downloading and preparation of music for the VR game Ragnarock.

## Overview

This script is designed to download all VR tracks from [RagnaCustoms](https://ragnacustoms.com/) and prepare them for use with the Oculus Quest 3 VR headset. It extracts the music files and optimises them into the right format.

## Features

- Automated downloading of music files from RagnaCustoms
- Extraction of downloaded files
- Preparation and optimization of files for Oculus Quest 3

## Requirements

- A Windows computer
- A USB cable to connect the Oculus Quest 3 to the computer
- PowerShell (pre-installed on Windows)

## Installation and Usage

1. **Run Script**:
    - Download the `RagnarockVR-MusicDownloader.ps1' script and save it to your computer or copy it into the Powershell ISE.
    - Open PowerShell and navigate to the location where the script is saved.
    - Run the script with the following command:

    ```powershell
    .\RagnarockVR-MusicDownloader.ps1
    ```

2. **Connect Headset**:
    - Connect your headset to your computer via a USB cable.
    - Enable USB data transfer mode by confirming the popup on your headset.

3. **Prepare Folder Structure**:
    - Open the Meta Quest/Pico folder in the File Explorer on your computer.
    - Navigate to: `Internal shared storage > Android > data > com.wanadev.ragnarockquest > files > UE4Game > Ragnarock > Ragnarock > Saved`.
    - Create a folder named `CustomSongs` in this location.

4. **Troubleshooting**:
    - If script execution is not allowed, set the execution policy to allow the script to run Powerhsell with Admin rights:
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    ```
    - After running the script, you can revert the execution policy to its original state:
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy Default
    ```
    - If not all songs are downloaded, increase the value of the `startIndex` in the script. This may be necessary as this value needs to be set to the latest.
    - Example: Change the line `$startIndex = 3645` to the current start index.

## Example Code

```powershell
# RagnarockVR-MusicDownloader.ps1

$startIndex = 3645  # Adjust the current start index

# Further script code follows...
