# Author: Sam Kagan
# Date modified: 5/17/2021

function track-remote-branch --description "Create a git branch that tracks a selected remote branch"
    # Because local copies of remote branches aren't kept up-to-date automatically
    git fetch
    if test (count $argv) -gt 0
        set query_flag --query=$argv[(count $argv)]
    end

    set -l remote_branch (_select-other-branches $query_flag --remote) # Should always be a valid Git branch name
    set -l local_branch (echo $remote_branch | sd '^.+/' '') # remote_branch is valid ==> local_branch is valid

    if test -n $local_branch
        echo
        git branch $local_branch -t $remote_branch
        git switch $local_branch
    else
        return 1
    end
end
