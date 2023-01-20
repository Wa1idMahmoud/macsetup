Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@Wa1idMahmoud 
onlyonehas
/
mac_dev_setup
Public
Fork your own copy of onlyonehas/mac_dev_setup
Code
Issues
Pull requests
Actions
Projects
Security
Insights
mac_dev_setup/setup.sh
@onlyonehas
onlyonehas Update setup.sh
…
Latest commit c546b78 on Jul 22, 2022
 History
 1 contributor
Executable File  76 lines (63 sloc)  2.51 KB

#!/usr/bin/env bash

# Mac software update 
# softwareupdate --all --install --force

# Xcode https://developer.apple.com/download/all/?q=command%20line%20tools
# should install git by default
# xcode-select --install

# administrator access
sudo -v

# Keep-alive until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add homebrew to path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

# ohmyzsh, zsh-autosuggestions and Zsh-z
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# essential non-gui apps
brew install node
brew install python
brew install python3
brew install docker
brew install starship
brew install awscli
brew install redis
brew install java
brew install remotemobprogramming/brew/mob
brew upgrade remotemobprogramming/brew/mob
npm i -g np

# fonts.
brew tap bramstein/webfonttools
brew tap homebrew/cask-fonts
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# essential apps - gui
brew install --cask --appdir="/Applications" font-hack-nerd-font
brew install --cask --appdir="/Applications" alfred
brew install --cask --appdir="~/Applications" iterm2
brew install --cask --appdir="/Applications" google-chrome
brew install --cask --appdir="/Applications" firefox
brew install --cask --appdir="/Applications" slack
brew install --cask --appdir="/Applications" numi
brew install --cask --appdir="/Applications" zoom.us
brew install --cask --appdir="/Applications" microsoft-outlook
brew install --cask --appdir="/Applications" visual-studio-code
brew install --cask --appdir="/Applications" maccy
# brew install --cask --appdir="/Applications" 1clipboard
brew install --cask --appdir="/Applications" gpg-suite
brew install --cask --appdir="/Applications" sourcetree
brew install --cask --appdir="/Applications" flux
brew install --cask --appdir="/Applications" cheatsheet
brew install --cask --appdir="/Applications" fig
fig settings autocomplete.immediatelyExecuteAfterSpace true

brew cleanup
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
mac_dev_setup/setup.sh at main · onlyonehas/mac_dev_setup
