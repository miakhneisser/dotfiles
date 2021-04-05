which brew &>/dev/null || {
  log "> Install Package Manager"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  xcode-select --install
}

sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks /usr/local/Homebrew
chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks /usr/local/Homebrew

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://iterm2.com/downloads/stable/iTerm2-3_4_4.zip)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git >> ~/
curl https://raw.githubusercontent.com/rupa/z/master/z.sh >> ~/z.sh

cat ~/.dotfiles/.zshrc > ~/.zshrc
cat ~/.dotfiles/robbyrussell.zsh-theme > ~/.oh-my-zsh/themes/robbyrussell.zsh-theme
cat ~/.dotfiles/git.zsh > ~/.oh-my-zsh/lib/git.zsh
