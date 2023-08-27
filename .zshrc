# Part copied from luke smith's old config @ https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# Colours
autoload -U colors && colors

# PROMPT
autoload -U promptinit; promptinit
# Using the powerline at https://github.com/denysdovhan/spaceship-prompt
# Dont forget to run "npm install -g spaceship-prompt"
prompt spaceship

# Make it print out the whole path
SPACESHIP_DIR_TRUNC=0
# To prevent it from showing vi mode
SPACESHIP_VI_MODE_SHOW=false
# To prevent it from showing node.js version number
SPACESHIP_NODE_SHOW=false

# PROMPT='%F{green}[%F{183}aa %F{81}%/%F{green}]%F{162}%#%f '


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
export HISTFILE=~/.cache/.zsh_history

# Adding timestamps and Appending History Immediately
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

# Remove duplicates when going up in terminal
setopt HIST_FIND_NO_DUPS

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# setting defaults
export EDITOR='nvim'
export VISUAL='nvim'

# Coloured Man pages by setting colours for less
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# -------------------------------------------------------------------------------- #
# Aliases

# ls
# l for more detail, a for all files even hidden ones, and h for headings; git for some git info
alias ls='exa -lah --git'

# search through text files in a directory using rip-grep
alias search='rg -S' # some string, some directory

alias cat='bat' # better rust tool for cat

alias wikipedia='wiki-tui'

# make joplin launch with the gui apps notes:
# alias joplin='joplin --profile ~/.config/joplin-desktop/'
# Use one drvie to sync them

# -------------------------------------------------------------------------------- #
# mac only:
if [[ "$OSTYPE" == "darwin"* ]]; then
    # to open chrome in a compatible way to linux
    alias chromium='open -a Google\ Chrome'

    # to set BROWSER to open google chrome properly
    export BROWSER='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

    # export llvm from brew
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
fi

# linux only:
if [[ $OSTYPE == "linux"* ]]; then
    export BROWSER=chromium
fi


# -------------------------------------------------------------------------------- #

# For own scripts
export PATH="$HOME/Programming/shell_scripts:$PATH"
# For go programs
export PATH="$HOME/go/bin:$PATH"
# llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# For compilers to find llvm you may need to set:
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"

# pywal
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)
# source ~/.cache/wal/colors-tty.sh

# for highlighting requires zsh-syntax-highlighting
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source /opt/homebrew/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# for prompt: starship
# eval "$(starship init zsh)"

# to fix zeal docsets https://github.com/zealdocs/zeal/issues/1155#issuecomment-553213420
zeal-docs-fix() {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}
fpath=($fpath "/Users/aaqsr/.zfunctions")
fpath=($fpath "/Users/aaqsr/.zfunctions")
fpath=($fpath "/Users/aaqsr/.zfunctions")


# For doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"

# for flutter
export PATH="$PATH:/$HOME/prog/flutter/bin"

# for Android Debug Bridge
export PATH="$PATH:/$HOME/prog/platform-tools"

[ -f "/Users/aaqsr/.ghcup/env" ] && source "/Users/aaqsr/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.local/bin"

# export STACK_YAML="$HOME/.config/stack.yaml"

export PATH="$PATH:/usr/local/texlive/2022/bin/universal-darwin"

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

alias neofetch='neofetch --ascii_distro arch'

# NEOVIM CONFIG SWITCHER
# DEPENDS ON FZF
# SOURCE https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b

alias nvim-old="NVIM_APPNAME=old nvim"

function nvims() {
  items=("default" "old")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  # $@ just adds any positional args you input
  NVIM_APPNAME=$config nvim $@
}

