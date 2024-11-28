###### START aliases ######

# connection related
function as {
    param(
        [string]$server
    )
    $sshCommand = "ssh $USER@elvis0$server.kaist.ac.kr"
    Invoke-Expression $sshCommand
}

function a {
    param(
        [string]$server
    )
    $sshCommand = "ssh $USER@elvis$server.kaist.ac.kr"
    Invoke-Expression $sshCommand
}

# app related
function gas { & 'C:\Program Files (x86)\Hourglass\Hourglass.exe' --title $args[0] $args[1] }
function t { C:\Program Files\AutoHotkey\v2.0.16\AutoHotkey64.exe C:\Users\anat0my\playground\script\win\AutoHotkey\tmux.ahk }
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

function acsa {
    & git add -A
    & git commit -m "$args[0]"
    & git push --all
}

function gezs {
    & cp $HOME\.gitconfig $HOME\playground\win-environment\win\.gitconfig
    & cd $HOME\playground\win-environment\
    & git pc '[win][.gitconfig]'
}

# terminal related
function vzsr { notepad $PROFILE.CurrentUserAllHosts }

function fetchv {
	cp $HOME\playground\win-environment\win\Profile.ps1 $PROFILE.CurrentUserAllHosts
}

function vezs {
    & cp $PROFILE.CurrentUserAllHosts $HOME\playground\win-environment\win\Profile.ps1
    & cd $HOME\playground\win-environment\
    & git pc '[win][Profile.ps1]'
}

function gzsr { notepad $HOME\.gitconfig }
function fetchg {
	cp $HOME\playground\win-environment\linux\.gitconfig $HOME\.gitconfig
}
function gezs {
    & cp $HOME\.gitconfig $HOME\playground\win-environment\linux\.gitconfig
    & cd $HOME\playground\win-environment\
    & git pc '[win][Profile.ps1]'
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

function gput { Git-Url pull upstream topuzz }
function gpum { Git-Url pull upstream main }
function gpuma { Git-Url pull upstream master }
function gpot { Git-Url pull origin topuzz }
function gpom { Git-Url pull origin main }
function gpoma { Git-Url pull origin master }

function gpushut { Git-Url push upstream topuzz }
function gpushum { Git-Url push upstream main }
function gpushuma { Git-Url push upstream master }
function gpushot { Git-Url push origin topuzz }
function gpushom { Git-Url push origin main }
function gpushoma { Git-Url push origin master }
function gpushfut { Git-Url push -f upstream topuzz }
function gpushfum { Git-Url push -f upstream main }
function gpushfuma { Git-Url push -f upstream master }
function gpushfot { Git-Url push -f origin topuzz }
function gpushfom { Git-Url push -f origin main }
function gpushfoma { Git-Url push -f origin master }

function greset { git reset --hard }
function gresetut { greset upstream/topuzz }
function gresetum { greset upstream/main }
function gresetuma { greset upstream/master }
function gresetot { greset origin/topuzz }
function gresetom { greset origin/main }
function gresetoma { greset origin/master }

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

###### END aliases ######
