# Copy profile and config files
$profileDir = Split-Path -parent $profile

New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue

# Set up profile from repo profile folder
Copy-Item -Path ".\profile\*" -Destination $profileDir

# home config files/folders from repo home folder
# Copy-Item -Force -Path ".\home\**" -Destination $home -Recurse -Include **

# appdata files from repo to system
Copy-Item -Force -Path ".\appdata\local\*" -Destination "C:\Users\Jason\AppData\Local" -Recurse -Include **

# home config files/folders from repo home folder
Copy-Item -Force -Path ".\config\**" -Destination $home"\.config\" -Recurse -Include **

Remove-Variable profileDir

