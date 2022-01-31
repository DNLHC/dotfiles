if [ -f $HOME/.bash_aliases ]
then
  . $HOME/.bash_aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export EDITOR='nvim'
