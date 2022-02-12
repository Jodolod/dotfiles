# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH



# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
. "$HOME/.cargo/env"

# Alias
alias vim='nvim'
alias idea="/opt/idea/bin/idea.sh"

# Function to parse git branch and show in prompt
source ~/dotfiles/git-prompt.sh

#export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]\$(__git_ps1 " (%s)")\[\033[00m\] $ '
#PS1='\u@\h \W[\033[32m\]\$(__git_ps1)\[\033[00m\] $ '
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(__git_ps1)\[\033[00m\] $ "
