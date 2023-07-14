# Author: Sam Kagan
# Date modified: 5/17/2021

function switch-to-branch --description "Switch to a Git branch chosen through fzf search"
    if test (count $argv) -gt 0
        set query_flag --query=$argv[(count $argv)]
    end
    _select-other-branches $query_flag |
    xargs git switch 
end
