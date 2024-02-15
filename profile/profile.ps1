# menu completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Aliases
Set-Alias ll ls

Set-Alias touch New-Item

# Determine size of a file or total size of a directory
Set-Alias fs Get-DiskUsage

# Empty the Recycle Bin on all drives
Set-Alias emptytrash Empty-RecycleBin

# Cleanup old files all drives
Set-Alias cleandisks Clean-Disks

# Reload the shell
Set-Alias reload Reload-Powershell

Invoke-Expression (&starship init powershell)