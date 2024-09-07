# Powershell settings 
# ------------------------------------
# menu completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Aliases
# ------------------------------------

# Use ls alias for listing files (may not be ideal if you have `ls` as an alias for another command)
Set-Alias ll ls

# Create a new item (file or directory)
Set-Alias touch New-Item

# Get the command information (alternative to `which` in other shells)
Set-Alias which Get-Command

Set-Alias ld lazydocker

Set-Alias lg lazygit

# Quick exit terminal
function T-Exit {
	exit
}
Set-Alias q T-Exit

# Change to the home directory
function Go-Home {
    Set-Location $HOME
}
Set-Alias home Go-Home

# Change to the dotfiles directory
function Go-Dotfiles {
    Set-Location $HOME/dotfiles
}
Set-Alias dots Go-Dotfiles

# CMake with MinGW Makefiles generator
function Mingw-cmake {
	cmake .. -G "MinGW Makefiles"
}
Set-Alias wincmake Mingw-cmake

# Use mingw32-make for make (usually requires installation)
function Mingw-make {
	mingw32-make
}
Set-Alias winmake Mingw-make
