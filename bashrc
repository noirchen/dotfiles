# completion
[[ -f /etc/bash_completion ]] && ! shopt -oq posix && . /etc/bash_completion
export SOURCEFILE=$HOME/.bash_profile

# color
export CLICOLOR=1
export PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^ \u@\h\[\e[0m\]; else echo \[\e[31m\]O_O \u@\h\[\e[0m\]; fi\`[\t] \[\033[01;31m\]\W\$\[\033[00m\] "
alias grep='grep --color=always'
alias la='ls -lhA'

# vi mode
shopt -s -o vi

# software
source /opt/intel/compilers_and_libraries_2019/linux/bin/compilervars.sh intel64
source /opt/intel/mkl/bin/mklvars.sh intel64
source /opt/intel/impi/2019.3.199/intel64/bin/mpivars.sh

export PATH=/opt/software/mpi/mvapich2/bin:$PATH
export LD_LIBRARY_PATH=/opt/software/mpi/mvapich2/lib:$LD_LIBRARY_PATH

export PATH=/opt/software/mpi/mpich/bin:$PATH

export PATH=$HOME/software/bin:$HOME/software/cmake-3.15.2/bin:$PATH
export PATH=/opt/software/miniconda3/bin:$PATH

# if hash module 2>/dev/null; then
# # modules and applications
# module load matlab
# module load python
# export MATLABPATH=$MATLABPATH:$TOOL
# export PATH="$HOME/texlive/bin/x86_64-linux":$PATH

# queue
# alias qsubu='qsub -q generic'
# alias qsubul='qsub -q longgen '
# alias qstatu='qstat -u user '
# alias qclean='rm *sh.{e,o}[0-9]*'
alias freenodes='pbsnodes -l all'

# language environment
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# vim
alias v="vim"
alias d='vim -c"windo set wrap" -d $*'

# snippets
alias l="ls -lht"
alias gh="cd /home/chenjiangzhi"
alias gd="cd /data/chenjiangzhi"
alias db="d $HOME/.bashrc $HOME/cjz/sync/bashrc"

# rsync
send() {
    # send a local file or folder to remote server
    rsync -ravz --exclude=.DS_Store "$1" chenjiangzhi@10.10.15.200:~/sync/"$2"
}

# OpenFOAM
alias openfoam='source $HOME/software/OpenFOAM/OpenFOAM-v1812/etc/bashrc'

# lammps
export LAMMPS_PATH=/opt/inspur/software/lammps-5Jun19
export PATH=$LAMMPS_PATH/src:$PATH
export LAMMPS_POTENTIALS=$LAMMPS_PATH/potentials

# gromacs
source $HOME/software/gromacs/bin/GMXRC

# conda
update() {
    echo "Upgrading Anaconda"
    conda upgrade --all -y
    conda update --all -y
    conda clean --all -y
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/software/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/software/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/software/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
