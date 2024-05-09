# Author: Sam Kagan
# Date modified: 4/25/2022

function _select-other-branches --description "Select git branch(es) other than the current one. Options are --single, --remote, and --query=<initial-query>"
    set -l options (fish_opt -s m -l multi)
    set -a options (fish_opt -s r -l remote)
    set -a options (fish_opt -s q -l query --required-val)
    argparse $options -- $argv; or return # Exit if arg-parsing fails
    if test -n $_flag_query
        set query_flag --query=$_flag_query
    end

    git branch --sort=committerdate --list $_flag_remote |
        tac |
        rg --invert-match '\*|\->' | # Exclude current branch and remote HEADs
        cut -c 3- |
        fzf $query_flag $_flag_multi --preview='git log {} --'
end
