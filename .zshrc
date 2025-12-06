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
export HISTFILE=$HOME/.cache/.zsh_history

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
alias ls='eza -lah --git'

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
    # export BROWSER='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

    # Arc doesn't work
    # export BROWSER="open -a Arc "

    # export BROWSER='/Applications/Safari.app/Contents/MacOS/Safari'

    # export llvm from brew
    # export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

    # For compilers to find llvm you may need to set:
    export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
    # set c/c++ compiler to brew clang
    export CC="/opt/homebrew/opt/llvm/bin/clang"
    export CXX="/opt/homebrew/opt/llvm/bin/clang++"

    # finder
    alias finder="open"

    # sdl2
    export PATH="/opt/homebrew/Cellar/sdl2/:$PATH"
    # brew 
    export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
fi

# linux only:
if [[ $OSTYPE == "linux"* ]]; then
    source "$HOME/.zsh/spaceship/spaceship.zsh"
    # export BROWSER=chromium
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
if [[ $OSTYPE == "linux"* ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# https://github.com/zsh-users/zsh-syntax-highlighting
if [[ "$OSTYPE" == "darwin"* ]]; then
# source /opt/homebrew/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# for auto-suggestions Requires zsh-autosuggestions
# just install it via brew 
# brew install zsh-autosuggestions
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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

alias nvim-old="NVIM_APPNAME=nvim-old nvim"

function nvim-switch() {
  items=("default" "nvim-old" "nvim-avish" "pure")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  # $@ just adds any positional args you input such as a file name that you want to open
  NVIM_APPNAME=$config nvim $@
}

alias nvims=nvim-switch

# Java moment
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
# . "$HOME/.cargo/env"

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/aaqsr/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/aaqsr/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# eval "$(/opt/homebrew/bin/brew shellenv)"

##
# Your previous /Users/aaqsr/.zprofile file was backed up as /Users/aaqsr/.zprofile.macports-saved_2022-03-25_at_16:15:53
##

# MacPorts Installer addition on 2022-03-25_at_16:15:53: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-03-25_at_16:15:53: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/aaqsr/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/aaqsr/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# C++
# source ~/cs246e/setup
alias g++20m="g++-13 -std=c++20 -fmodules-ts -Wall -g"
alias g++20h="g++-13 -std=c++20 -fmodules-ts -c -x c++-system-header"
alias g++20i="g++-13 -std=c++20 -Wall -g"
alias g++-13="/opt/homebrew/Cellar/gcc/13.2.0/bin/g++-13"

alias clangdconfig="nvim ~/Library/Preferences/clangd/config.yaml"

# Get the weather!
alias weather="curl wttr.in/"
alias weather_uw="curl wttr.in/~waterloo+canada"
alias forecast="curl wttr.in/"

# For dotNET
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export PATH=$PATH:$HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet

# zoxide a better cd. run this after compinit
#   alias it to cd
eval "$(zoxide init --cmd cd zsh)"
export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm@15/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@15/include"

# add brew to pkg-config
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"

# opam configuration
[[ ! -r /home/aaqsr/.opam/opam-init/init.zsh ]] || source /home/aaqsr/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Coq Path
  export PATH="/Applications/CoqIDE_8.10.2.app/Contents/Resources/bin:$PATH"
fi

export PATH=/opt/homebrew/Cellar/cling/1.2/bin:$PATH
export PATH=/opt/homebrew/Cellar/:$PATH
export PATH=$HOME/verible/bin:$PATH
export PATH=$HOME/prog/synlig:$PATH
export PATH=/Applications/IINA.app/Contents/MacOS:$PATH

export VCPKG_ROOT="$HOME/vcpkg"

# bun completions
[ -s "/Users/aaqsr/.bun/_bun" ] && source "/Users/aaqsr/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"


# obsidian vault todo/tasks
alias todo="nvim $HOME/Documents/Obsidian\ Vault/Main\ Vault/Tasks.md"
alias tasks=todo
