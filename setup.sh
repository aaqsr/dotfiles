#!/bin/bash

set -e

# Colours
BOLD="\033[1m"
OFF="\033[m"


# Confirm prompt function
confirm() {
    read -r -p "${1:-Continue?} [y/N]: " reply
    [[ "$reply" =~ ^[Yy]$ ]]
}

# Welcome message
# Had to be done this way because cat does not let me bold text
cat <<EOF
  ___   ___ _____ ___ ___ _    ___ ___ 
 |   \ / _ \_   _| __|_ _| |  | __/ __|
 | |) | (_) || | | _| | || |__| _|\__ \

 |___/ \___/ |_| |_| |___|____|___|___/
                                        
Welcome to the dotfiles minimal setup script.

Last updated: 6 December 2025

EOF

echo -e "You **${BOLD}must${OFF}** run this script from your home directory."
echo ""
echo -e "Before running this, you **${BOLD}must${OFF}** install the following packages"

cat <<EOF
and ensure that they available on your path via your preferred 
method before proceeding,
    - git           (required)
    - zsh           (optional)
        - npm           (for zsh prompt)
        - nodejs        (for zsh prompt)
    - neovim        (optional)
        - rust/cargo(optional)
EOF

if ! confirm "Have you installed the dependencies?"; then
    echo "Please install them first, then run this script."
    exit
fi

echo "Setting up dotfiles..."

if confirm "Install zsh prompt? [zsh/npm required]"; then
    echo "Installing spaceship-prompt may require manual setup."
    npm install -g spaceship-prompt # for zsh prompt
fi

# dotfiles sync https://github.com/aaqsr/dotfiles.git

# Idea for using git bare repo from:
# https://www.atlassian.com/git/tutorials/dotfiles

echo "Setting dotfiles alias in bashrc and zshrc. If neither apply, fix manually"

echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >>"$HOME/.bashrc"
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >>"$HOME/.zshrc"

# set alias for this script too
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >>"$HOME/.gitignore"

git clone --bare https://github.com/aaqsr/dotfiles.git "$HOME/.dotfiles"

mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles."
else
    echo "Backing up pre-existing dot files."
    dotfiles checkout 2>&1 | grep -E "\s+\." | awk "{'print $1'}" | xargs "-I{}" mv "{}" ".dotfiles-backup/{}"
fi
dotfiles checkout
dotfiles config status.showUntrackedFiles no

cat <<EOF
...Done!

To manage dotfiles in the future, use the \`dotfiles\` alias with
\`git\` commands to, for example,
    - dotfiles pull                 (pull changes)
    - dotfiles push                 (push changes)
    - dotfiles add <file>           (add file to dotfiles repo)
    - dotfiles commit -am <msg>     (commit changes to dotfiles)

Bye!!
EOF
