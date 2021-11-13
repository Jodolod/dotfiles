# General aliases
alias ll='ls -la'
alias ..='cd ..'

# Program aliases
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'




# Function to parse git branch and show in prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}


# Shell prompt
# Server user
# Server root

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(parse_git_branch)\[\e[00m\]$ "
