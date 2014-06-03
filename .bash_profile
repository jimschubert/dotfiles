if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.bash/welcome.sh ]; then
  sh ~/.bash/welcome.sh
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
