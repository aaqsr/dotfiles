# Parts copied from luke smith's old config @ https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

# Colours ; PROMPT
# Using the powerline at https://github.com/denysdovhan/spaceship-prompt
# Dont forget to run "npm install -g spaceship-prompt"
autoload -U colors && colors
autoload -U promptinit; promptinit
prompt spaceship

# Make it print out the whole path
SPACESHIP_DIR_TRUNC=0

# PROMPT='%F{green}[%F{183}aa %F{81}%/%F{green}]%F{162}%#%f '


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

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

# -------------------------------------------------------------------------------- #
# Aliases
alias ls='exa --long --git'
# -------------------------------------------------------------------------------- #

# For own scripts
export PATH="$HOME/Programming/shell_scripts:$PATH"
# For go programs
export PATH="$HOME/go/bin:$PATH"

# pywal
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# for highlighting requires zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
