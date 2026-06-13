# This is my opinionated dotfiles repository

## Install

```bash
cd ~ && \
curl -o install.sh https://raw.githubusercontent.com/bpetrukovich/dotfiles-fish/main/.install/setup.sh && \
chmod +x install.sh && \
./install.sh
```

## Description

- [nvim](https://github.com/neovim/neovim) as editor.
- [tmux](https://github.com/tmux/tmux) as terminal multiplexer.
- [fzf](https://github.com/junegunn/fzf) as fuzzy finder.
- [zoxide](https://github.com/ajeetdsouza/zoxide) as smarter cd.
- [Delta](https://github.com/dandavison/delta) as git diff pager.
- [Bat](https://github.com/sharkdp/bat) as better cat.
- [Starship](https://github.com/starship/starship) as prompt.
- [Atoin](https://github.com/atuinsh/atuin) for persistent shell history.
- [gita](https://github.com/nosarthur/gita) to manage a lot of git repos.

- [fnm](https://github.com/Schniz/fnm) as node version manager.

- [ripgrep](https://github.com/BurntSushi/ripgrep) as faster grep.

- [lazygit](https://github.com/jesseduffield/lazygit) as git ui.
- [lazydocker](https://github.com/jesseduffield/lazydocker) as docker ui.

### Fish shell

- [Fish](https://github.com/fish-shell/fish-shell) as shell.
- [fisher](https://github.com/jorgebucaran/fisher) as plugin manager.
- [fzf.fish](https://github.com/PatrickF1/fzf.fish)
- [zoxide.fish](https://github.com/kidonng/zoxide.fish)

## Postinstall

Remove install.sh from home directory.

Create separate .gitconfig-profile file in home directory with email and name and change .gitconfig. (see ~/.gitconfig)

BTW install script will ask for email and name for personal and work git accounts and create those files

## Features

### "Done" script

You can run "done some-task" to get notification when this task is done.

see ~/.config/fish/functions/done.fish

## Maintain this repository

```bash
sudo apt-get install -y dotnet-sdk-10.0 # update with latest version
```

## TODO

- fix tldr
