# == ALIASES ======================================= #

git config --global alias.last 'cat-file commit HEAD'

# == COLORS ======================================= #

#git config color.branch auto
#git config color.diff auto
#git config color.interactive auto
#git config color.status auto

# == global == #

git config color.ui true

# == TEMPLATES ======================================= #

git config commit.template '/etc/git-commit-template'

# == LOG ======================================= #

git config format.pretty oneline

# == EDITOR ======================================= #

git config --global core.editor 'open -a /Applications/MacVim/MacVim.app/Contents/MacOS/MacVim'
git config --global diff.tool '/Applications/DiffMerge.app/Contents/MacOS/DiffMerge $LOCAL $REMOTE'
git config --global merge.tool '/Applications/DiffMerge.app/Contents/MacOS/DiffMerge'

# == MORE ALIASES ======================================= #

git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch

# == IGGY ======================================= #

echo ".DS_Store" >> ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# == BASH COMPLETION ======================================= #

#cp /opt/local/etc/bash_completion.d/git ~/.git-bash-completion.sh
#echo "[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh" >> ~/.bash_profile
#. ~/.bash_profile

