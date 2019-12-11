# check if using zsh or bash
# if [[ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]]; then
#     # Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DISABLE_UPDATE_PROMPT=true
    ZSH_THEME="ys"
plugins=(sublime web-search osx brew vim-mode zsh-syntax-highlighting)
    source $ZSH/oh-my-zsh.sh
    [[ ! -d $ZSH/custom/plugins/zsh-syntax-highlighting ]] && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    setopt correct
    export SOURCEFILE=$HOME/.zshrc
    alias zshconfig="subl ~/.zshrc"

# elif [[ -n "$($SHELL -c 'echo $BASH_VERSION')" ]]; then
#     # completion
#     [[ -f /etc/bash_completion ]] && ! shopt -oq posix && . /etc/bash_completion
#     export SOURCEFILE=$HOME/.bash_profile

#     # color
#     export CLICOLOR=1
#     export PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^ \u@\h\[\e[0m\]; else echo \[\e[31m\]O_O \u@\h\[\e[0m\]; fi\`[\t] \[\033[01;31m\]\W\$\[\033[00m\] "
#     alias grep='grep --color=always'
#     alias la='ls -lhA'

#     # vi mode
#     shopt -s -o vi

#     if hash module 2>/dev/null; then
#         # modules and applications
#         module load matlab
#         module load python
#         export MATLABPATH=$MATLABPATH:$TOOL
#         export PATH="$HOME/texlive/bin/x86_64-linux":$PATH

#         # queue
#         alias qsubu='qsub -q generic'
#         alias qsubul='qsub -q longgen '
#         alias qstatu='qstat -u jiangzhi'
#         alias qclean='rm *sh.{e,o}[0-9]*'
#         convertsecs(){
#             h=$(( $1 / 3600 ))
#             m=$(( $1 % 3600 / 60 ))
#             s=$(( $1 % 60 ))
#             printf "%02d hours %02d minutes and %02d seconds\n" $h $m $s
#         }
#     fi
# fi

# language environment
    export LC_CTYPE=en_US.UTF-8
    export LANG=en_US.UTF-8

# software and scripts
    [[ "$OSTYPE" == "cygwin" ]] && export DROPBOX=/cygdrive/d/Dropbox || export DROPBOX=$HOME/Dropbox
    [[ "$OSTYPE" == "darwin"* ]] && export APPS=/Applications && source $HOME/.iterm2_shell_integration.zsh
    [[ -d $DROPBOX ]] && export PREF=$DROPBOX/Sync/Preference && export TOOL=$DROPBOX/Research/Scripts
    export PATH=$PATH:$TOOL:.

# snippets
    alias lsd="ls -lht | grep --color=never '^d'"
    alias please='sudo $(fc -nl -1)'

# vim
    [[ -d $APPS/MacVim.app ]] && alias vim="$APPS/MacVim.app/Contents/MacOS/Vim"
    alias v="vim"
    alias d='vim -c"windo set wrap" -d $*'

# sync
    alias dv="d $HOME/.vimrc $PREF/vimrc"
    alias db="d $SOURCEFILE $PREF/profile"

# rsync
# alias saciss="rsync -rtvu -h --delete $DROPBOX --exclude '.dropbox' --exclude '.dropbox.cache' --exclude '.DS_Store' --exclude 'desktop.ini' --exclude '.git' jiangzhi@aciss.uoregon.edu:"
# alias snewberry="rsync -rtvu -h --delete $DROPBOX --exclude '.dropbox' --exclude '.dropbox.cache' --exclude '.DS_Store' --exclude 'desktop.ini' --exclude '.git' jiangzhi@newberry.uoregon.edu:"
# alias sall="saciss;snewberry"

# matlab
    [[ -d $APPS/MATLAB.app ]] && export PATH=$PATH:$APPS/MATLAB.app/bin
    alias matlab="matlab -nodesktop -nosplash"

# sublime text
    [[ -d $APPS/Sublime\ Text.app ]] && export PATH=$APPS/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH

# homebrew
    if [[ -d $APPS/homebrew ]]; then
    export PATH="$APPS/homebrew/bin":$PATH
    alias rm=rmtrash
    if hash brew 2>/dev/null; then
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
    . "$(brew --prefix)"/etc/bash_completion
    fi
    list() {
        normal=$(tput sgr0) # reset the foreground colour
            blue=$(tput setaf 4)
            magenta=$(tput setaf 5)
            brew list |
            {
                while read cask
                    do
                        echo -n ${blue} $cask ${normal} '-> '
                            brew uses $cask --installed | awk '{printf(" %s ", $0)}'
                            echo ""
                            done
                            echo ${magenta} Total packages $(brew list -l | sed '1d' | wc -l) ${normal}
            }
    }
fi
fi

# gmt
[[ -d $APPS/GMT.app ]] && export PATH=$APPS/GMT.app/Contents/Resources/bin:$PATH

# mathematica
[[ -d $APPS/Mathematica.app ]] && alias math="$APPS/Mathematica.app/Contents/MacOS/MathKernel"

# Anaconda
[[ -d $APPS/anaconda ]] && export PATH=$APPS/anaconda/bin:$PATH

# update homebrew and anaconda
update() {
    if hash brew 2>/dev/null; then
        echo "Updating Homebrew"
            brew update
            echo "Upgrading Homebrew"
            brew upgrade --all
            echo "Some additional cleaning"
            brew cleanup --force
            /bin/rm -rf $(brew --cache)
            fi
            if hash conda 2>/dev/null; then
                echo "Upgrading Anaconda"
                    conda update conda
                    conda update anaconda
                    fi
}

# telnet
alias telnet="luit -encoding gbk telnet"

# lilypond
[[ -d $APPS/LilyPond.app ]] && export PATH=$PATH:$APPS/LilyPond.app/Contents/Resources/bin

# mpv
[[ -d $APPS/mpv.app ]] && export PATH=$PATH:$APPS/mpv.app/Contents/MacOS

# say
[[ ! -f /usr/bin/say ]] && [[ -f /usr/bin/espeak ]] && alias say='echo "$1" | espeak -s 120 2>/dev/null'

hash wget 2>/dev/null || alias wget='curl -O'

hash free 2>/dev/null || free () { top -l 1 -s 0 | grep -m 1 PhysMem ; }

# # ssh
# alias newberry="ssh jiangzhi@newberry.uoregon.edu"
# alias aciss="ssh -X jiangzhi@aciss.uoregon.edu"
