function fish_user_key_bindings
    fish_vi_key_bindings

    bind \cf 'multi-sessionizer'
    bind -M insert \cf 'multi-sessionizer'

    # Tmux Harpoon (see ~/.local/scripts/tmux-harpoon)
    # Should be in sync with ~/.tmux.conf
    bind \eh 'tmux-harpoon go 1'
    bind \ej 'tmux-harpoon go 2'
    bind \ek 'tmux-harpoon go 3'
    bind \el 'tmux-harpoon go 4'
    bind -M insert \eh 'tmux-harpoon go 1'
    bind -M insert \ej 'tmux-harpoon go 2'
    bind -M insert \ek 'tmux-harpoon go 3'
    bind -M insert \el 'tmux-harpoon go 4'

    # Multi Sessionizer (see ~/.local/scripts/multi-sessionizer)
    # Should be in sync with ~/.tmux.conf
    bind \eo 'multi-sessionizer switch /home/bogdan/obsidian-vault'
    bind \en 'multi-sessionizer switch /home/bogdan/.config/nvim'
    bind \e\` 'multi-sessionizer switch /home/bogdan'
    bind -M insert \eo 'multi-sessionizer switch /home/bogdan/obsidian-vault'
    bind -M insert \en 'multi-sessionizer switch /home/bogdan/.config/nvim'
    bind -M insert \e\` 'multi-sessionizer switch /home/bogdan'

    bind ctrl-alt-b fzf_search_git_branch
    bind -M insert ctrl-alt-b fzf_search_git_branch
end
