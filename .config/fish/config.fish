set fish_greeting

if status is-interactive
    atuin init fish --disable-up-arrow | source
    starship init fish | source
end

set fzf_diff_highlighter delta --paging=never --width=20
