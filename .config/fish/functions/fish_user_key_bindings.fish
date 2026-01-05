function fish_user_key_bindings
    fish_vi_key_bindings

    bind \cf 'multi-sessionizer'
    bind -M insert \cf 'multi-sessionizer'

    # Harpoon
    bind \eh 'tmux-harpoon go 1'
    bind \ej 'tmux-harpoon go 2'
    bind \ek 'tmux-harpoon go 3'
    bind \el 'tmux-harpoon go 4'
    bind -M insert \eh 'tmux-harpoon go 1'
    bind -M insert \ej 'tmux-harpoon go 2'
    bind -M insert \ek 'tmux-harpoon go 3'
    bind -M insert \el 'tmux-harpoon go 4'

    # Quick sessions
    bind \eo 'multi-sessionizer /home/bogdan/obsidian-vault'
    bind \en 'multi-sessionizer /home/bogdan/.config/nvim'
    bind \e\` 'multi-sessionizer /home/bogdan'
    bind -M insert \eo 'multi-sessionizer /home/bogdan/obsidian-vault'
    bind -M insert \en 'multi-sessionizer /home/bogdan/.config/nvim'
    bind -M insert \e\` 'multi-sessionizer /home/bogdan'
end
