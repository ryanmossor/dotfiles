# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

function Write-BranchName {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red" -NoNewline
        } else {
            Write-Host " ($branch)" -ForegroundColor "yellow" -NoNewline
        }
    } catch {
        Write-Host " (no branches yet)" -ForegroundColor "yellow" -NoNewline
    }
}

function prompt {
    $PROMPT = ""

    if ($ExecutionContext.SessionState.Path.CurrentLocation.Provider.Name -eq 'FileSystem') {
        $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

        if ($currentPath.StartsWith($HOME, [System.StringComparison]::OrdinalIgnoreCase)) {
            $currentPath = "~" + $currentPath.Substring($HOME.Length)
        }

        $PROMPT += $currentPath.Replace("\", "/")
    }

    if (Test-Path .git) {
        Write-Host $PROMPT -ForegroundColor "blue" -NoNewline
        Write-BranchName
    } else {
        Write-Host $PROMPT -ForegroundColor "blue" -NoNewline
    }

    Write-Host " >" -ForegroundColor "green" -NoNewline
    return " "
}

function bp { . $profile }
function cbp { cat $profile }
function ebp { code $profile }
function work { Set-Location "$HOME\code\work" }

function pid-search([int]$LookupPort) { netstat -ano | findstr "PID :$LookupPort" }
function pid-kill([int]$Port) { taskkill /pid $Port /f }

function cwd { (Get-Location) -split '\r?\n' | Select-Object -Last 1 }
Set-Alias ll ls
Set-Alias touch New-Item
Set-Alias grep findstr
Set-Alias xsc clip

Set-Alias screenkey "$HOME\code\KeyCastOW\build\keycastow.exe"
Set-Alias vs "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe"
