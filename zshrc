. ~/.zsh/config
. ~/.zsh/load_oh_my_zsh
. ~/.aliases
. ~/.zsh/aliases
. ~/.zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# User specific aliases and functions
if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export EDITOR=vim

# Special mode to launch zsh with a command but return to an interactive shell if stopped (for use with tmux)
if [[ $1 == eval ]]
then
  "$@"
  set --
fi
alias zshi='zsh -is eval' 

