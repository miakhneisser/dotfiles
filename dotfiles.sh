which brew &>/dev/null || {
  log "> Install Package Manager"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  xcode-select --install
}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://iterm2.com/downloads/stable/iTerm2-3_4_4.zip)"
brew install zsh-syntax-highlighting
curl https://raw.githubusercontent.com/rupa/z/master/z.sh >> ~/z.sh

cat ~/.dotfiles/robbyrussell.zsh-theme > /Users/$USER/.oh-my-zsh/themes/robbyrussell.zsh-theme
cat ~/.dotfiles/git.zsh > /Users/$USER/.oh-my-zsh/lib/git.zsh
