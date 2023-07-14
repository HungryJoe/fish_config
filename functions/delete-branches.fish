# Author: Sam Kagan
# Date modified: 5/17/2021

function delete-branches --description "Delete Git branches selected by fzf search"
    if test (count $argv) -gt 0
        set query_flag --query=$argv[(count $argv)]
    end
    _select-other-branches --multi $query_flag |
    xargs git branch --delete --force
end
