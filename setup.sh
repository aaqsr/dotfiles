# for mac
# assuming you have homebrew installed
if [[ "$OSTYPE" == "darwin"* ]]; then
   brew install nodejs npm
fi

# for linux
if [[ $OSTYPE == "linux"* ]]; then

  # for arch
  if [ -f "/etc/arch-release" ]; then
  sudo pacman -Syyu nodejs npm
  
  # dependencies
   sudo pacman -S neovim # neovim cause neovim 
  
  # else assumes ubuntu
  else
    # idk if this works ngl
    sudo apt update && sudo apt upgrade
    sudo apt install nodejs npm
    
  fi
  
fi

sudo npm install -g dotfiles-sync
dotfiles sync https://github.com/aaqsr/dotfiles.git

# pulls dependencies
npm install -g spaceship-prompt # for zsh prompt
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # neovim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # vim plug




# put this in ur home
# remember to set it to be executable by chmod +x
