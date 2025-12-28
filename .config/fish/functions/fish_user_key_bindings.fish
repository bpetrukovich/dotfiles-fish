function fish_user_key_bindings
    fish_vi_key_bindings

    bind \cf 'multi-sessionizer'
    bind \ce 'script-selector'

    bind -M insert \cf 'multi-sessionizer'
    bind -M insert \ce 'script-selector'
end
