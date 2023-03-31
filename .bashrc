# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


#--------------------
# ENVIRONMENT VARS
#--------------------
export REPOS="$HOME/Repos"
export DOTFILES="$REPOS/dotfiles"
export ZETTELKASTEN="$REPOS/zet"
export SCRIPTS="$DOTFILES/scripts"
export VISUAL=vi
export EDITOR=vi
export PYENV_DIR="$HOME/.python_envs" # for virtual python environments with venv
export GEM_HOME="$HOME/.ruby"

export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export PATH="$HOME/.local/bin:${SCRIPTS}:/usr/local/go/bin:${HOME}/.ruby/bin:${PATH}:$HOME/.cargo/bin"
export CDPATH="$REPOS:${CDPATH}"

[ -n "$(uname -a | grep WSL)" ] && export CDPATH="/mnt/c/Users/Constantin:${CDPATH}"


#--------------------
# HISTORY
#--------------------
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend


#--------------------
# SHELL OPTIONS
#--------------------
# vi style command line editing
set -o vi
shopt -s globstar

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# necessary for __ps1
shopt -s checkwinsize


#--------------------
# PAGER
#--------------------
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#--------------------
# PROMPT
#--------------------

MIN_COLS=80
MAX_PROMPT=60

__ps1() {
	local red='\[\e[1;31m\]' green='\[\e[1;32m\]' blue='\[\e[1;34m\]' \
		nocol='\[\e[0m\]' branch countme dir

	branch="$(git branch --show-current 2>/dev/null)"
	[[ -n "$branch" ]] && branch=" ($branch) " || branch=""

	countme="\u@\h:\w${branch}\$ "
	countme="${countme@P}"

	if (( COLUMNS - ${#countme} < MIN_COLS
	   || ${#countme} > MAX_PROMPT )); then
		PS1="╔ $green\u@\h$nocol:$blue\w$red${branch}$nocol\n╚ \$ "
	else
		PS1="$green\u@\h$nocol:$blue\w$red${branch}$nocol$ "
	fi
}

PROMPT_COMMAND="__ps1"


#--------------------
# ALIASES
#--------------------
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias dot="cd $DOTFILES"
alias scripts="cd $SCRIPTS"
alias zet="cd $ZETTELKASTEN"
alias zzetnew="zet && zetnew"
alias zz="zzetnew"
alias '?'=duck
alias '??'=google
alias free='free -h'
alias df='df -h'
alias less='less -I' # ignore case when searching less or man pages
alias view='vi -R' # vi is usually aliased to vim

# only if vim is installed
type vim &>/dev/null && alias vi=vim


#--------------------
# SHELL FUNCTIONS
#--------------------
pyenv_create () {
	if (($# != 1)); then
		echo "Usage: pyenv_create <env_name>"
		return 1
	fi
	python3 -m venv "${PYENV_DIR}/$1"
}

pyenv_activate () {
	local env_dir
	env_dir="${PYENV_DIR}/$1"
	if (($# != 1)); then
		if [[ -d "${PYENV_DIR}/base" ]]; then 
			env_dir="${PYENV_DIR}/base"
		else
			echo "Usage: pyenv_activate <env_name>"
			return 1
		fi
	fi
	source "${env_dir}/bin/activate"
}

pyenv_destroy () {
	if (($# != 1)); then
		echo "Usage: pyenv_destroy <env_name>"
		return 1
	fi
	rm -r "${PYENV_DIR}/$1"
}

zetnew () {
	local dir
	dir=$(isosec)
	mkdir $dir
	cd $dir
	touch README.md
	vi README.md
}

export -f pyenv_create pyenv_activate pyenv_destroy zetnew

#--------------------
# PYTHON
#--------------------
if [[ -d "${PYENV_DIR}/base" ]]; then 
	pyenv_activate
fi


#--------------------
# COMPLETION
#--------------------
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# custom completion
complete -C viewmd viewmd
