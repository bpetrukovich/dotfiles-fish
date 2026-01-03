#!/bin/bash
set -e

if [ ! -f /proc/version ] || ! grep -qi microsoft /proc/version; then
    echo "This script is optimized for WSL. Continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        exit 1
    fi
fi

# suppress messages displayed when logging in
touch ~/.hushlogin

# essential
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential ca-certificates git unzip curl wget ripgrep jq make

# fish
sudo apt-add-repository -y ppa:fish-shell/release-4
sudo apt update
sudo apt install -y fish
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"

# nerd font
# Needed to be installed in the host windows system and setted up in terminal like WezTerm, Alacritty or Windows Terminal
# But won't hurt in wsl
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip && unzip -o /tmp/JetBrainsMono.zip -d /tmp/jb_font && mkdir -p ~/.local/share/fonts && cp /tmp/jb_font/*.ttf ~/.local/share/fonts/ && fc-cache -f && rm -rf /tmp/JetBrainsMono.zip /tmp/jb_font

curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes

# fzf
# no change in rc file
# checkout https://github.com/junegunn/fzf/blob/master/install for help
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-key-bindings --completion --no-update-rc

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# atuin
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | sh
# rm .zshrc, because this script creates it
# TODO: also will be good to remove trash from the end of the .bashrc
rm -rf ~/.zshrc
~/.atuin/bin/atuin login
~/.atuin/bin/atuin sync

# tools for git
sudo apt install -y git-delta

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm -rf lazygit lazygit.tar.gz

# ------------ docker ------------
curl -fsSL https://get.docker.com | sudo sh
sudo groupadd docker -f
sudo usermod -aG docker $USER
echo "Restart wsl or run 'newgrp docker' to apply docker rules"

# disable starting docker on boot
# BUT it will start on docker command eg. `docker run` 
sudo systemctl disable docker.service
sudo systemctl disable containerd.service

sudo apt install -y docker-compose-plugin

# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# ---------------------------------

# usefull
# sudo apt install -y tshark
sudo apt install -y tldr fd-find eza bat sd ncdu btop
ln -s /usr/bin/batcat ~/.local/bin/bat
# download the database immediately so you don’t have to wait later
tldr -u

# node (fnm)
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell # no change in rc file
export FNM_DIR="$HOME/.local/share/fnm"
if [ -d "$FNM_DIR" ]; then
    export PATH="$FNM_DIR:$PATH"
    eval "$(fnm env --shell=bash)"
fi
fnm install --lts

# dotnet

sudo apt-get install -y dotnet-sdk-10.0
dotnet tool install --global dotnet-ef

# tmux + tpm
sudo apt install -y tmux tmuxp
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# prefix + I to install all plugins from config

# git config

echo ""
echo "=== Git config ==="

read -p "Personal email for Git: " personal_email
read -p "Personal name for Git: " personal_name

cat > ~/.gitconfig-personal << EOF
[user]
    email = $personal_email
    name = $personal_name
EOF

echo "Personal git config is saved in: ~/.gitconfig-personal"

read -p "Work email for  Git: " work_email
read -p "Work name for Git: " work_name

cat > ~/.gitconfig-work << EOF
[user]
    email = $work_email
    name = $work_name
EOF

echo "Work git config is saved in: ~/.gitconfig-work"

# ssh + github
# NOTE: creates without password
# TODO: clip.exe is not stable, so need to replace
ssh-keygen -t ed25519 -C $personal_email -f ~/.ssh/id_ed25519 -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
if command -v clip.exe &> /dev/null; then
    cat ~/.ssh/id_ed25519.pub | clip.exe
    echo "ssh key with personal email is copied to the windows clipboard and can be pasted to github"
else
    echo "=== SSH KEY ==="
    cat ~/.ssh/id_ed25519.pub
    echo "Copy given key to GitHub"
fi
read -p "Press Enter after adding ssh key to GitHub..."

# TODO: we can repeat with work email if user wants

# dotfiles
git clone --bare git@github.com:bpetrukovich/dotfiles-fish.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME branch --set-upstream-to=origin/main main
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

# neovim

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# easy-dotnet deps
dotnet tool install --global EasyDotnet

# treesitter deps
npm install -g tree-sitter-cli

echo "Attempting to clone nvim config..."
if git clone git@github.com:bpetrukovich/nvim-archive.git ~/.config/nvim 2>/dev/null; then
    echo "✓ nvim config cloned successfully"
    nvim --headless "+Lazy! sync" +qa
else
    echo "⚠ Could not clone nvim config. You may need to add SSH key to GitHub first."
fi

echo "Attempting to clone obsidian vault..."
if git clone git@github.com:bpetrukovich/obsidian.git ~/obsidian-vault 2>/dev/null; then
    echo "✓ obsidian vault cloned successfully"
else
    echo "⚠ Could not clone obsidian vault. You may need to add SSH key to GitHub first."
fi

# all programming related projects
mkdir -v ~/personal ~/work
# 
mkdir -v ~/personal/sandbox ~/work/sandbox
mkdir -v ~/personal/pet 

# buffer, all external files go here first, then either transferred or deleted from here. Thanks to this folder, all others remain clean
mkdir -v ~/buffer

# work (TODO: move to separate script)

# aws

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws/ awscliv2.zip

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
rm -rf session-manager-plugin.deb

# kubectl

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -rf kubectl

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install kidonng/zoxide.fish
fisher install PatrickF1/fzf.fish

npm install @ast-grep/cli -g

# gita
# sudo apt install python3-pip
# sudo apt install -y pipx
# pipx ensurepath
# pipx install gita

# ----
# TODO:
echo "Need to set up system limits: fs.inotify.max_user_instances, fs.inotify.max_user_watches, ulimit"

# Healthcheck
