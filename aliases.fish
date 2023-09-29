function which-test
    # OS-agnostic which
    if test -f /etc/os-release
        # On Linux
        which $argv[1] > /dev/null 2> /dev/null
    else
        # On MacOS
        which -s $argv[1]
    end
end


alias x=exit
alias c=clear

if which-test grep
    alias grep="grep --color always"
end

if which-test nvim
    alias nv='nvim'
else
    alias nvim='vim'
    alias nv='vim'
end

if which-test exa
    alias ls=exa
    alias ds='exa --tree --git-ignore --icons'
    alias dsl='exa --tree --git-ignore --icons --level'
else if which-test eza
    alias ls=eza
    alias ds='eza --tree --git-ignore --icons'
    alias dsl='eza --tree --git-ignore --icons --level'
    
end

if which-test dust
    alias du=dust
end

if which-test bat
    alias less='bat --paging=always'
else
    # For .gitconfig's core.pager
    alias bat='less'
end

if which-test btm
    alias top=btm
end

if which-test git
    alias g='git'
    alias ga='git add'
    alias gcom='git commit -m'
    alias gcoa='git commit --amend'
    alias gs='git status'
    alias gp='git push'
    alias gpl='git pull'
    alias gd='git diff'
    alias gl='git log'
    alias gsbm='git switch main'
    alias gb='git switch -c'
    alias gpu='git push -u origin'

    alias gsb='switch-to-branch'
    alias gbd='delete-branches'
end

if which-test docker
    alias d='docker'
    alias dc='docker compose'
    alias dcu='docker compose up'
    alias dcd='docker compose down'
end
