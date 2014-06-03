#!/bin/bash

snippets=( _ autoit c cpp html java javascript mako objc perl php python ruby sh snippet tcl tex vim zsh )

for val in "${snippets[@]}"
do
  wget https://raw.github.com/ryanb/dotfiles/master/vim/snippets/$val.snippets
done
