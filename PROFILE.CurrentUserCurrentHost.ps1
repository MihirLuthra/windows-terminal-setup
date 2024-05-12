# get fzf on ctrl+r
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# zsh like tab completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Add path to Environment.
function Add-Path() {
	param (
		[Parameter(Mandatory = $True)]
		[string]$Directory
	)

	try {
		$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

		if ($currentPath -notcontains $Directory) {
			$newPath = $currentPath + ";$Directory"
			[System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
			Write-Host "Added '$Directory' to Path."
		} else {
			Write-Host "Directory '$Directory' is already in the Path."
		}
	}
	catch {
		Write-Error "Failed to add '$Directory' to the Path. Error: $_"
		throw
	}
 }

# Aliases
New-Alias -Name gh -Value Get-Help
Remove-Item alias:type; Set-Alias -Name type -Value Get-Command
New-Alias -Name vim -Value nvim
New-Alias -Name vi -Value nvim

# Functions
function n() {
  cd C:\Users\MihirLuthra\AppData\Local\nvim
}

# Git
function gs() { git status @args }
function ga() { git add @args }
Remove-Item -Force alias:gc; function gc() { git commit -m @args }
Remove-Item -Force alias:gcm; function gcm() { git commit --amend @args }
function gr() { git rebase -i @args }
function gb() { git branch @args }
function grv() { git remote -v @args }
Remove-Item -Force alias:gl; function gl() { git log @args }
function gd() { git diff @args }
