# for mac and windows
export ZSH=$HOME/.oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH_THEME="spaceship"
if [[ $OSTYPE == darwin* ]]; then
    plugins=(web-search osx zsh-syntax-highlighting)
else
    plugins=(command-not-found web-search zsh-syntax-highlighting)
fi
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
[[ ! -d $ZSH/custom/plugins/zsh-syntax-highlighting ]] && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
setopt correct
export SOURCEFILE=$HOME/.zshrc
[[ ! -f ~/.zprofile ]] && ln -s ~/.zshrc ~/.zprofile
alias sbp="source ~/.zshrc"

# software and scripts
if [[ $OSTYPE == darwin* ]]; then
    source $HOME/.iterm2_shell_integration.zsh
    export DROPBOX=$HOME/Dropbox
elif [[ $OSTYPE == linux-gnu ]]; then
    export DROPBOX=/mnt/c/Users/jzche/Dropbox
fi

export PATH=$PATH:$DROPBOX/Research/Scripts:$DROPBOX/Sync/Scripts

# snippets
alias lsd="ls -lht | grep --color=never '^d'"
alias gd='cd $HOME/Downloads'

# vim key binding
bindkey -v

# quick folder navigation
alias here='echo cd \"$PWD\" >~/.here.sh'
alias there='source ~/.here.sh'

# vim
[[ -d /Applications/MacVim.app ]] && alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias v=vim
alias vi=vim
alias d='vim -c"windo set wrap" -d $*'
export EDITOR=vim

# sync
alias dv="d $HOME/.vimrc $DROPBOX/Sync/Preference/vimrc"
# [[ $OSTYPE == darwin* ]] or [[ $OSTYPE == linux-gnu ]]
alias db="d $SOURCEFILE $DROPBOX/Sync/Preference/zshrc"

# aria2
if type aria2c 2>/dev/null>/dev/null; then
    [[ ! -d $HOME/.aria2 ]] && mkdir $HOME/.aria2 && cp $DROPBOX/Sync/Preference/aria2.conf $HOME/.aria2 && sed -i -- "s/username/$(whoami)/g" .aria2/aria2.conf
    alias aria2c="aria2c --conf-path=$HOME/.aria2/aria2.conf"
fi

# git
alias gb="git branch -avv"
alias gf="git fetch;git diff master..origin/master"
alias gm="git merge origin/master"
alias gl="clear;git status;git log --pretty=format:"%h %s %ad" --graph --since=1.days --date=relative;git log --show-signature -n 1"
alias gbs="git status;git add . -A;git commit -m"Update";git push"
function gas() {
    git status;
    git add . -A;
    git commit -m "$1";
    git push;
}

# matlab
[[ -d /Applications/MATLAB.app ]] && alias matlab="/Applications/MATLAB.app/bin/matlab -nodesktop -nosplash"

# mathematica
[[ -d /Applications/Mathematica.app ]] && alias math="/Applications/Mathematica.app/Contents/MacOS/MathKernel"

# homebrew
if [[ -d /Applications/homebrew ]]; then
    export BREW=/Applications/homebrew
    export PATH=$BREW/bin:$PATH
    if [ -f $BREW/etc/bash_completion ]; then
        . $BREW/etc/bash_completion
    fi
fi
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

# gmt
[[ -d /Applications/GMT.app ]] && export PATH=/Applications/GMT.app/Contents/Resources/bin:$PATH

# anaconda
# install miniconda, see install_tools.sh
[[ -d $BREW/anaconda3 ]] && export PATH=$BREW/anaconda3/bin:$PATH
if [[ $OSTYPE == linux-gnu ]]; then
    alias conda="/mnt/d/anaconda/Scripts/conda.exe"
    alias ipython="/mnt/d/anaconda/Scripts/ipython.exe"
fi
# It is better to add the path to /etc/paths
export PYTHONPATH=$DROPBOX/Research/Scripts/code/python/:$PYTHONPATH

alias zshconfig="vi ~/.zshrc"
[[ -d /Applications/CotEditor.app ]] && alias cot="/Applications/CotEditor.app/Contents/SharedSupport/bin/cot"

# typora
[[ $OSTYPE == darwin* ]] && alias typora="open -a /Applications/Typora.app"
[[ $OSTYPE == linux-gnu ]] && alias typora="/mnt/c/Program\ Files/Typora/Typora.exe"

type wget 2>/dev/null>/dev/null || alias wget='curl -O'

type free 2>/dev/null>/dev/null || free () { top -l 1 -s 0 | grep -m 1 PhysMem ; }

# pymol
export QT_QPA_PLATFORM_PLUGIN_PATH=$BREW/opt/qt/plugins

# gromacs
export GMXLIB=$HOME/OneDrive/model/md/gromacs/GMXLIB
alias clean="rm -f \#*\#"

# ssh
inspur() {
    ssh -Yy chenjiangzhi@10.10.15.200
}
marvin() {
    ssh -Yy chenjz@10.2.21.187
}
th() {
    ssh -i .nscc/nscc_key idsse_jzchen_1@172.16.22.11
}

# rsync
send() {
    # send a local file or folder to remote server
    rsync -ravz --exclude=.DS_Store "$1" chenjiangzhi@10.10.15.200:~/sync/"$2"
}
fetch() {
    # fetch a remote file or folder to current folder
    rsync -ravz --exclude=.DS_Store chenjiangzhi@10.10.15.200:~/sync/"$1" .
}
push() {
    # push to marvin
    rsync -avzHP ~/Dropbox chenjz@10.2.21.187:~/
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Applications/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Applications/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Applications/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Applications/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# conda config --set auto_activate_base False
