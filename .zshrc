export ZSH=/Users/$USER/.oh-my-zsh

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="avit"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
	git
	bundler
	dotenv
	osx
	rake
	history
	extract
	yarn

)

source $ZSH/oh-my-zsh.sh
source /Users/$USER/zsh-syntax-highlighting/zsh-syntax-highlighting.sh

# z extension for browsing
. ~/z.sh

# docker aliases
alias d=docker
alias dc=docker-compose
alias dup='docker-compose up -d'

# other aliases
alias p=python
alias n=node
alias g=git
alias o='zz "open ."'
alias topten='history | commands | sort-rn | head'
alias update='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'

# custom functions
gpr() {
	if [ $? -eq 0]; then
		github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
		branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
		pr_url=$github_url"/compare/master..."$branch_name
		open $pr_url;
	else
		echo 'failed to open a pull request.';
	fi
}
