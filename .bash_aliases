#!/bin/bash

alias P='cd ~/projects'
alias D='cd ~/Downloads'
alias ls='ls --color'

alias update='sudo dnf update && sudo dnf upgrade'
alias deb='sudo dpkg -i'
alias r='npm run'

alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias boldssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias removezone='find . -name "*:Zone.Identifier" -type f -delete'
alias explorer.exe='/mnt/c/Windows/explorer.exe'
alias code='code-insiders'

# git shortcuts
alias gst='git status'
alias ga='git add -A .'
alias gc='git commit -m'
alias gb='git branch'
alias gdi="git diff -- ':!package-lock.json' ':!*.lock'"
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias gt='git tag'
alias gm='git merge'
alias gg='git log --graph --pretty=format:"%C(bold red)%h%Creset -%C(bold yellow)%d%Creset %s %C(bold green)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gcp='git cherry-pick'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gpod='git push origin develop'
alias gpom='git push origin master'
