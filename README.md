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
- [fzf](https://github.com/junegunn/fzf) as fuzzy finder.
- [zoxide](https://github.com/ajeetdsouza/zoxide) as smarter cd.
- [Delta](https://github.com/dandavison/delta) as git diff pager.
- [Bat](https://github.com/sharkdp/bat) as better cat.
- [Starship](https://github.com/starship/starship) as prompt.
- [Atoin](https://github.com/atuinsh/atuin) for persistent shell history.
- [gita](https://github.com/nosarthur/gita) to manage a lot of git repos.

- [fnm](https://github.com/Schniz/fnm) as node version manager.

- [lazygit](https://github.com/jesseduffield/lazygit) as git ui.
- [lazydocker](https://github.com/jesseduffield/lazydocker) as docker ui.

- [ast-grep](https://github.com/ast-grep/ast-grep) for ast search.
- [tree-sitter](https://github.com/tree-sitter/tree-sitter) for parsing as dependency.
- [ripgrep](https://github.com/BurntSushi/ripgrep) as faster grep.
- [fd](https://github.com/sharkdp/fd) as faster find.
- [jq](https://github.com/stedolan/jq) for json manipulation.
- [eza](https://github.com/eza-community/eza) replaces ls.
- [sd](https://github.com/chmln/sd) for simpler sed.
- [btop](https://github.com/aristocratos/btop) as resource monitor.
- ncdu for free disk space.
- [wsl-open](https://github.com/4U6U57/wsl-open) to open wsl files in windows explorer.

### Docker

- docker with docker-compose
- Don't start on boot, but start on docker command eg. `docker run`

### Tmux

- [tmux](https://github.com/tmux/tmux) with TPM as terminal multiplexer.
- [tmuxp](https://github.com/tmux-python/tmuxp) as session manager.

### Fonts

JetBrains Mono font

### Runtimes

- python
- dotnet
- nodejs

build-essential and make for C/C++

### Fish shell

- [Fish](https://github.com/fish-shell/fish-shell) as shell.
- [fisher](https://github.com/jorgebucaran/fisher) as plugin manager.
- [fzf.fish](https://github.com/PatrickF1/fzf.fish)
- [zoxide.fish](https://github.com/kidonng/zoxide.fish)

## Postinstall

Remove install.sh from home directory.

Create separate `.gitconfig-profile` file in home directory with email and name and change .gitconfig. (see `~/.gitconfig`)

BTW install script will ask for email and name for personal and work git accounts and create those files

Set up system limits: fs.inotify.max_user_instances, fs.inotify.max_user_watches, ulimit

## Features

### Tmux

#### Multisessionizer

see `~/.local/scripts/multi-sessionizer`, `~/.tmux.conf`, `~/.config/fish/functions/fish_user_key_bindings.fish`

#### Tmux Harpoon

see `~/.local/scripts/tmux-harpoon`, `~/.tmux.conf`, `~/.config/fish/functions/fish_user_key_bindings.fish`

### Fish

#### `Done` utility

You can run `done some-task` to get notification when this task is done.

Eg. `done "dotnet build"` will notify you when dotnet build is done.

see `~/.config/fish/functions/done.fish`

#### `col N` utility

You can pipe output of any command to `col N` to get N column

Eg. `git status -s | col 2` to get all changed files

see `~/.config/fish/functions/col.fish`

#### fzf

`ctrl-alt-b` to search git branches (see `~/.config/fish/functions/fzf_search_git_branch.fish`)
`ctrl-alt-f` to search files
`ctrl-alt-s` to search git status
`ctrl-alt-l` to search git log
`ctrl-alt-p` to search processes
`ctrl-alt-v` to search variables

### Scripts

#### clone-all

Clone all repos listed in files

#### collect-remotes

Collect all remotes from all repos so you can later clone them with `clone-all`

## Maintain this repository

```bash
sudo apt-get install -y dotnet-sdk-10.0 # update with latest version
```

## TODO

- fix tldr
