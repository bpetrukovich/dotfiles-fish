set fish_greeting

if status is-interactive
    fzf_configure_bindings --history= --variables=\e\cv
    atuin init fish --disable-up-arrow | source
    starship init fish | source
end

set --global fish_key_bindings fish_vi_key_bindings

set fzf_diff_highlighter delta --paging=never --width=20
set fzf_fd_opts --hidden
