set fish_greeting

if status is-interactive
    atuin init fish --disable-up-arrow | source
    fzf --fish | FZF_CTRL_R_COMMAND= source
    starship init fish | source
end
zoxide init --cmd cd fish | source
