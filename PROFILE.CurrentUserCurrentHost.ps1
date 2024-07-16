# zsh like tab completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Function to add input path to System Environment.
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

# Add path to powershell env
function PS-Add-Path() {
	param (
		[Parameter(Mandatory = $True)]
		[string]$Directory
	)

  $currentPath = $env:Path

  if ($currentPath -notcontains $Directory) {
    $newPath = $currentPath + ";$Directory"
      $env:Path = $newPath
      Write-Host "Added '$Directory' to Current PS Path."
  } else {
    Write-Host "Directory '$Directory' is already in the Path."
  }
 }

# Aliases
New-Alias -Name gh -Value Get-Help
Remove-Item alias:type; Set-Alias -Name type -Value Get-Command
New-Alias -Name vim -Value nvim
New-Alias -Name vi -Value nvim
Remove-Item alias:cd; Set-Alias -Name cd -Value pushd

# Functions
$windowsTerminalSetupDir = 'C:\Users\MihirLuthra\windows-terminal-setup'
function n() {
  cd C:\Users\MihirLuthra\AppData\Local\nvim
}
function wp() {
  nvim $windowsTerminalSetupDir\PROFILE.CurrentUserCurrentHost.ps1
}
function wts() {
  cd $windowsTerminalSetupDir
}
function wtso() {
  cd $windowsTerminalSetupDir
  nvim PROFILE.CurrentUserCurrentHost.ps1
}
function cdw() {
  cd ~
}
function cs() {
  cd C:\src
}

# Git
function gs() { git status @args }
function ga() { git add @args }
Remove-Item -Force alias:gc; function gc() { git commit -m @args }
Remove-Item -Force alias:gcm; function gcm() { git commit --amend @args }
function gr() { git rebase -i @args }
function gb() { git branch @args }
function gch() { git checkout @args }
function grv() { git remote -v @args }
Remove-Item -Force alias:gl; function gl() { git log @args }
function gd() { git diff @args }

# Sets vars from Visual Studio
function VisualStudio-Setup() {
  . "$PSScriptRoot\visual-studio-vars.ps1"
}

function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation;

  $out = ""
    if ($loc.Provider.Name -eq "FileSystem") {
      $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
  return $out
}

# vcpkg
$env:VCPKG_ROOT = 'C:\Users\MihirLuthra\vcpkg'

# Just a function to do some setup later because powershell load times are slow.
# - posh git
function a() {
  # get fzf on ctrl+r
  Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

  Import-Module posh-git
  echo "posh-git imported"
}

## DOESN'T WORK
# invoke reverse fzf history
# function fzf-wrapper() {
#   param(
#     [int]$historySize = 5000
#   )
#   $historyPath = (Get-PSReadlineOption).HistorySavePath
#   $contents = Get-Content -Path $historyPath -Tail $historySize
#   [array]::Reverse($contents)
#   $selectedCommand = $contents | fzf --cycle 
#   if ($selectedCommand) {
#     Write-Host -nonewline $selectedCommand
#   } else {
#     Write-Host -nonewline "Nothing selected"
#   }
# }

# Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
#   fzf-wrapper
# }

