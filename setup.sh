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
  
  
  # else assumes ubuntu
  else
    # idk if this works ngl
    sudo apt update && sudo apt upgrade
    sudo apt install nodejs npm
    
  fi
  
fi

sudo npm install -g dotfiles-sync
dotfiles sync https://github.com/aaqsr/dotfiles.git

# put this in ur home
# remember to set it to be executable by chmod +x
