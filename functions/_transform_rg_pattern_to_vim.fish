# Author: Sam Kagan


function _transform_rg_pattern_to_vim --description "Transform vim_pattern from rg-friendly to Vim-friendly"
    set -l sd_prefix sd --string-mode
    set -l pattern $argv[1]

    set pattern (echo $pattern | $sd_prefix "+" "\+")
    set pattern (echo $pattern | $sd_prefix "?" "\?")

    # Assume that a boundary following a word character is looking for the end of a word, and a boundary preceding a word character is looking for the beginning of one
    set pattern (echo $pattern | sd "(\w)\\\\b" "\$1\>")
    set pattern (echo $pattern | sd "\\\\b(\w)" "\<\$1")

    # Swap escaped and unescaped parentheses since
    #   In Vim: \(\) -> capture group, while
    #   In rg: \(\) -> ()
    set pattern (echo $pattern | $sd_prefix "\(" "\`\`")
    set pattern (echo $pattern | $sd_prefix "\)" "\|\|")
    set pattern (echo $pattern | $sd_prefix "(" "\(")
    set pattern (echo $pattern | $sd_prefix ")" "\)")
    set pattern (echo $pattern | $sd_prefix "\`\`" "(")
    set pattern (echo $pattern | $sd_prefix "\|\|" ")")

    echo $pattern
end
