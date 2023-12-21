# Author: Sam Kagan
# Date modified: 9/17/2021

function select-files-to-edit --description "Select files to edit in Neovim using rg and fzf"
    set -l initial_query "$argv[-1]"  # Initial query, if any
    set -l search_path .
    if test (count $argv) -gt 1
        set search_path $query
        set initial_query "$argv[-2]"
    end
    set RG_PREFIX 'rg --files-with-matches'
    if test (count $argv) -gt 2
        set RG_PREFIX "$RG_PREFIX $argv[1..-3]"
    end

    # Based on snippet at: https://github.com/phiresky/ripgrep-all#integration-with-fzf
    set -l files_and_query (
        FZF_DEFAULT_COMMAND="$RG_PREFIX $initial_query $search_path" \
        fzf --sort \
            --preview='test ! -z {} && \
                rg --pretty --context 5 {q} {}' \
            --phony -q "$initial_query" \
            --bind "change:reload:$RG_PREFIX {q} $search_path" \
            --preview-window='50%:wrap' \
            --multi \
            --print-query
    ) || return $status

    set -l files "$files_and_query[2..-1]"
    # set -l query "$files_and_query[1]"
    # set -l vim_query (_transform_rg_pattern_to_vim $query)
    # set -l nvim_search -c "/$vim_query"
    echo $files | xargs hx
end
