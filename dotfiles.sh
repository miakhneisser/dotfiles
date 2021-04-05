log() { echo "\033[32m$@\033[0m"; }

# instal brew

which brew &>/dev/null || {
  log "> Install Package Manager"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  xcode-select --install
}

ls ~/.dotfiles &>/dev/null || {
  log "> Install Dotfiles"
  git clone https://github.com/vbrajon/dotfiles.git ~/.dotfiles
  for f in $(ls -d ~/.dotfiles/.* | grep -v '\.$' | grep -v '\.git$');do ln -fs $f ~;done
}

[[ -f ~/.extra ]] || {
  log "> Configure Dotfiles"
  T="node"
  P="atom brave-browser microsoft-office"
  N="http-server prettier raw"
  A="autocomplete-paths file-icons language-vue minimap minimap-cursorline pigments prettier-atom teletype"
  read -p "Name: ($NAME) " NAME
  read -p "Email: ($EMAIL) " EMAIL
  read -p "Hostname: ($HOSTNAME) " HOSTNAME
  read -p "Tools: ($T) " TOOLS
  read -p "Programs: ($P) " PROGRAMS
  read -p "Packages - Node: ($N) " PACKAGES_NODE
  read -p "Packages - Atom: ($A) " PACKAGES_ATOM
  read -p "Override Mac Preferences (Y/n)" MAC
  [[ $HOSTNAME ]] || HOSTNAME=$(hostname)
  [[ $TOOLS ]] || TOOLS=$T
  [[ $PROGRAMS ]] || PROGRAMS=$P
  [[ $PACKAGES_NODE ]] || PACKAGES_NODE=$N
  [[ $PACKAGES_ATOM ]] || PACKAGES_ATOM=$A
  cat > ~/.extra <<EOL
NAME="$NAME"
EMAIL="$EMAIL"
HOSTNAME="$HOSTNAME"
TOOLS="$TOOLS"
PROGRAMS="$PROGRAMS"
PACKAGES_NODE="$PACKAGES_NODE"
PACKAGES_ATOM="$PACKAGES_ATOM"
EOL
  cat > ~/.gitextra <<EOL
[user]
  name = $NAME
  email = $EMAIL
EOL
  curl -s https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore >> ~/.gitexcludes
  curl -s https://raw.githubusercontent.com/rupa/z/master/z.sh > /usr/local/etc/profile.d/z.sh
}

[[ $(date -r ~/.extra "+%H%M") == "0000" ]] || {
  log "> Install Packages"
  touch -t $(date +%Y%m%d0000) ~/.dotfiles/.extra
  source ~/.dotfiles/.extra
  brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
  brew install bash bash-completion@2 git tmux htop fzf fd ripgrep diff-so-fancy
  brew install $TOOLS
  brew install --cask $PROGRAMS
  npm install -g $PACKAGES_NODE
  apm install $PACKAGES_ATOM
  echo /usr/local/bin/bash >> /etc/shells
  chsh -s /usr/local/bin/bash
  open ~/.dotfiles/Raw.terminal
  defaults write com.apple.terminal "Default Window Settings" "Raw"
  defaults write com.apple.terminal "Startup Window Settings" "Raw"

  [[ "$MAC" != [Yy]* ]] && break
  log "> Update Mac Preferences"
  osascript -e 'tell application "System Preferences" to quit'
  sudo -v;while true;do sudo -n true;sleep 60;kill -0 "$$" || exit;done 2>/dev/null &
  scutil --set HostName "$HOSTNAME"
  scutil --set LocalHostName "$HOSTNAME"
  scutil --set ComputerName "$HOSTNAME"
  dscacheutil -flushcache
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  chflags nohidden /Volumes
  chflags nohidden ~/Library
  hash tmutil &> /dev/null && sudo tmutil disablelocal
  nvram SystemAudioVolume=" "
  touch ~/.bash_sessions_disable
}
