###### START aliases ######

function play { cd $HOME\playground }
function docs { cd $HOME\playground\Documents }

# connection related
function as {
    param(
        [string]$server
    )
    $sshCommand = "ssh gun@elvis0$server.kaist.ac.kr"
    Invoke-Expression $sshCommand
}

function a {
    param(
        [string]$server
    )
    $sshCommand = "ssh gun@elvis$server.kaist.ac.kr"
    Invoke-Expression $sshCommand
}

# app related
function gas { & 'C:\Program Files (x86)\Hourglass\Hourglass.exe' --title $args[0] $args[1] }
function t { C:\Program Files\AutoHotkey\v2.0.16\AutoHotkey64.exe $HOME\playground\script\win\AutoHotkey\tmux.ahk }
# git related
Set-Alias g git

function grv { git remote -v }
function gfet { git fetch upstream }
function gaas { git config --get-regexp alias }

function st {
    & git add -A
    & git commit -m "new post"
    & git push origin $args[0]
}

function aed {
    & git add -A
    & git commit --amend --no-edit
    & git push --force origin $args[0]
}

function Get-CommitHash {
    param ($inputString)
    if ($inputString -match '\.\.([a-f0-9]+)') {
        return $matches[1]
    }
}

function Get-RepoName {
    param ($inputString)
    if ($inputString -match 'github.com:([^ ]+)') {
        return $matches[1] -replace '\.git$'
    }
}

function Print-CommitUrl {
    param ($repo, $hash)
    Write-Output "https://github.com/$repo/commit/$hash"
}

function Git-Url {
    param ($action, $remote, $repo)
    $outputFile = [System.IO.Path]::GetTempFileName()
    git $action $remote $repo | Out-File -FilePath $outputFile -Encoding utf8
    $output = Get-Content $outputFile -Raw

    $commitHash = Get-CommitHash -inputString $output
    $repoName = Get-RepoName -inputString $output

    Write-Output $output
    Write-Output "$($action)ed commit: $commitHash"
    Print-CommitUrl -repo $repoName -hash $commitHash

    Remove-Item $outputFile
}

function gpum { Git-Url pull upstream main }
function gpuma { Git-Url pull upstream master }
function gpom { Git-Url pull origin main }
function gpoma { Git-Url pull origin master }
function gpushum { Git-Url push upstream main }
function gpushuma { Git-Url push upstream master }
function gpushom { Git-Url push origin main }
function gpushoma { Git-Url push origin master }
function gpushfum { Git-Url push -f upstream main }
function gpushfuma { Git-Url push -f upstream master }
function gpushfom { Git-Url push -f origin main }
function gpushfoma { Git-Url push -f origin master }

function grrou { git rrou }

# **server** related
function c { clear }
function x { exit }

# **alias** related
function wat {
    $profilePath = Join-Path $HOME "Documents\WindowsPowerShell\Profile.ps1"
    Get-Content $profilePath | Select-String -Pattern '###### START aliases ######', '###### END aliases ######' -Context 0,1 | Select-Object LineNumber, Line
}

function wat2 {
    $profilePath = Join-Path $HOME "Documents\WindowsPowerShell\Profile.ps1"
    Get-Content $profilePath | Select-String -Pattern '###### START aliases ######', '###### END aliases ######' -Context 0,2 | Select-Object LineNumber, Line
}

function watg {
    Get-Content "$HOME\.gitconfig" | Select-String -Pattern '.*' | Select-Object LineNumber, Line
}

function watg2 {
    Get-Content "$HOME\.gitconfig" | Select-String -Pattern '.*' -Context 0,2 | Select-Object LineNumber, Line
}

# environment
function vzsr { notepad $HOME\playground\environment\Profile.ps1 }
function gzsr { notepad $HOME\playground\environment\linux-environment\.gitconfig }
function vezs {
    & cd $HOME\playground\environment\
    & git pc 'Profile.ps1'
}
function gezs {
    & cd $HOME\playground\environment\linux-environment\
    & git pc '.gitconfig'
    & cd ..\
    & git pc '.gitconfig'
}

###### END aliases ######
