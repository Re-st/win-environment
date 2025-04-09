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
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )

    $outputFile = [System.IO.Path]::GetTempFileName()
    git @args | Out-File -FilePath $outputFile -Encoding utf8

    $output = Get-Content $outputFile -Raw
    $commitHash = Get-CommitHash -inputString $output
    $repoName = Get-RepoName -inputString $output

    Write-Output $output
    if ($commitHash) {
        Write-Output "$($args[0])ed commit: $commitHash"
    }
    if ($repoName -and $commitHash) {
        Print-CommitUrl -repo $repoName -hash $commitHash
    }

    Remove-Item $outputFile
}

function gpull { param($remote, $branch = $null)
    if ($null -ne $branch) {
        Git-Url pull $remote $branch
    } else {
        Git-Url pull $remote
    }
}

function gpush { param($remote, $branch = $null)
    if ($null -ne $branch) {
        git push $remote $branch
    } else {
        git push $remote
    }
}

function gpushf { param($remote, $branch = $null)
    if ($null -ne $branch) {
        git push -f $remote $branch
    } else {
        git push -f $remote
    }
}

function gfetch { param($remote = $null)
    if ($null -ne $remote) {
        git fetch $remote
    } else {
        git fetch
    }
}


function gpullu { param($branch = "main") gpull upstream $branch }
function gpullo { param($branch = "main") gpull origin $branch }
function gpushu { param($branch = "main") gpush upstream $branch }
function gpusho { param($branch = "main") gpush origin $branch }
function gpushfu { param($branch = "main") gpushf upstream $branch }
function gpushfo { param($branch = "main") gpushf origin $branch }
function gfetchu { param() gfetch upstream }
function gfetcho { param() gfetch origin }

function grhu { param($branch = "main") git reset --hard upstream/$branch }
function grho { param($branch = "main") git reset --hard origin/$branch }

function gfrhu { param($branch = "main") gfetchu; grhu $branch }
function gfrho { param($branch = "main") gfetcho; grho $branch }

function gpum { gpullu main }
function gpuma { gpullu master }
function gpom { gpullo main }
function gpoma { gpullo master }

function gpushum { gpushu main }
function gpushuma { gpushu master }
function gpushom { gpusho main }
function gpushoma { gpusho master }
function gpushopr { gpusho private }

function gpushfum { gpushfu main }
function gpushfuma { gpushfu master }
function gpushfom { gpushfo main }
function gpushfoma { gpushfo master }
function gpushfopr { gpushfo private }

function gfrhum { gfrhu main }
function gfrhuma { gfrhu master }
function gfrhom { gfrho main }
function gfrhoma { gfrho master }

function gssh { git stash }
function gsd { git stash drop }
function gsgsd { git stash; git stash drop }

function gspum { git stash; gpum; git stash pop }
function gspuma { git stash; gpuma; git stash pop }
function gspom { git stash; gpom; git stash pop }
function gspoma { git stash; gpoma; git stash pop }

function gsrhum { git stash; gfrhum; git stash pop }
function gsrhuma { git stash; gfrhuma; git stash pop }
function gsrhom { git stash; gfrhom; git stash pop }
function gsrhoma { git stash; gfrhoma; git stash pop }

function grrou { git rrou }
function gri { git rebase -i }
function grc { git rebase --continue }
function gdn { git diff --numstat }

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
# time 관련
function curtime { Get-Date -Format "HH:mm:ss" }
function timestamp { '-'*40 + ' ' + (curtime) + ' ' + '-'*40 }

# 디렉토리 생성 + 이동
function mkcd {
    param([string]$dir)
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    Set-Location $dir
}

# grep 대체: 전체 하위 폴더에서 문자열 검색
function gpw {
    param([string]$keyword)
    Get-ChildItem -Recurse -File | Select-String -Pattern $keyword
}

# 파일 이름에 특정 문자열 포함되었을 때 rename
function findsed {
    param([string]$keyword, [string]$replacement)
    Get-ChildItem -Recurse -File | Where-Object { $_.Name -like "*$keyword*" } |
    ForEach-Object {
        $newName = $_.Name -replace [regex]::Escape($keyword), $replacement
        Rename-Item $_.FullName -NewName $newName
    }
}

###### END aliases ######
