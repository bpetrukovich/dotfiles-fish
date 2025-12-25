set fish_greeting

fish_add_path ~/.local/bin
fish_add_path ~/.local/scripts/

if status is-interactive
    atuin init fish --disable-up-arrow | source
    fzf --fish | FZF_CTRL_R_COMMAND= source
    starship init fish | source
end
zoxide init --cmd cd fish | source
