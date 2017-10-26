# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

alias emacs="emacs -nw"

myfind() {
    find . -type f -name "*.*" -not -iwholename '*.svn*' -not -iwholename '*.a' -not -iwholename '*.o'  -exec grep -n -H $1 --colo=auto {} \; 2>/dev/null
}

myfind_i()
{
    find . -type f -name "*.*" -not -iwholename '*.svn*' -not -iwholename '*.a' -not -iwholename '*.o' -exec grep -n -H $1 --color=auto -i {} \;  2>/dev/null
}

ffmpeg_thumbsI()
{
    mkdir thumbs
    ffmpeg -i "$1" -vf scale=160:120 -vf fps=25 -vf select='eq\(pict_type\,I\)' -vsync vfr -vframes $2 thumbs/I_%03d.jpg && (ffprobe -select_streams v -show_entries frame=key_frame,pict_type,pkt_pts -show_frames -print_format compact -show_frames -loglevel quiet "$1"|grep I) > index.log
}

alias FIND=myfind
alias FINDI=myfind_i
alias cls=clear

export PAGER=less
export SHELL=/bin/bash
export EMAIL=lionel.carminati@contentarmor.tv


#LCA exp
export PATH=$PATH:/home/lcarminati/Downloads/Bento4/Bento4-SDK-1-5-0-614.x86_64-unknown-linux/bin/
export EDITOR="emacs"
export GVPKG_CONF_DIR="$HOME/local/etc"
export PYTHONPATH="$HOME/local/lib/python2.5/site-packages:$HOME/root/lib/python2.4/site-packages:/home/lcarminati/DEV/Watermark/CATools/lib/python2.7/site-packages"
export MOZILLA_FIVE_HOME=/usr/lib/mozilla
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib/:/cafvm/lib/

# active les couleurs
eval `dircolors -b`
alias CMAKED='rm -rf CMakeCache.txt CMakeFiles/; cmake -V -DCMAKE_BUILD_TYPE=debug -DCMAKE_BUILD_PRODUCT=bks350 .; make'
alias CMAKE='rm -rf CMakeCache.txt CMakeFiles/; cmake -V -DCMAKE_BUILD_TYPE=release -DCMAKE_BUILD_PRODUCT=bks350 .; make'
alias LAST='find . -maxdepth 1 -type f -exec stat --format "%Y :%y %n" "{}" \; | sort -nr | cut -d: -f2- | head'
alias ls='ls -al --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
alias ll='ls -al --color'
alias emacs='emacs -nw'
alias ssh="ssh -X"
alias find_big="find . -size +10M -exec ls -lh \"{}\" \;| sort -k 5 -rn"
alias ducks="du -hsx * | sort -rh | head -25"
alias c='clear'
alias less='less --quiet'
alias s='ssh -A "test -d \"$PWD\" && cd \"$PWD\"; bash -login"'
alias h='cd ~'
alias df='df --human-readable'
alias du='du -s --human-readable'
alias free='free -m'
alias psfs='pspresent -O Seascape'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias diff=colordiff
alias grep='grep --color'
alias xterm='xterm -bg white -fg black'
alias cls='clear'
alias rxvt='urxvt -fg grey90 -bg grey20 +sb -pr green -bc -cr green'
alias urxvt='urxvt -fg grey90 -bg grey20 +sb -pr green -bc -cr green'
alias rxvtrv='urxvt -rv +sb'
alias clean='find . \( -name "*.dbg" -o -name "*.kdev4" -o -name "*-" -o -name "*~" -o -name "CMakeCache.txt" -o -name "CMakeFiles" -o -name "*.pyc" -o -name "*.log" -o -name "cmake_install.cmake" \) -print0|xargs -0 \rm -rf --'   
alias find_big='find . -size +10M -exec ls -lh "{}" \;| sort -k 5 -rn'
alias find_exp='for i in `find . -type f -name "*.h" -o -name "*.c"`; do (cat $i | grep "va\.h") && echo $i; done'
alias chmodd='find . -type d -exec chmod 711 {} \;'
alias chmodf='find . -type f -exec chmod 755 {} \;'
alias iostat="iostat -m -x -d sda 1"
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias thumbsI=ffmpeg_thumbsI #usage ? <AVC|HEVC file> <nbIFrameToDecode>

alias DOS2UNIX='find . -type f -exec dos2unix {} \;'
alias VALGRIND=" valgrind -v --time-stamp=no --track-fds=no --db-attach=no --leak-check=full --show-reachable=no --leak-resolution=high --malloc-fill=0xFF --free-fill=0xAA --trace-children=no --partial-loads-ok=yes --num-callers=20 --log-file=valgrind.log --error-limit=no"
alias CALLGRIND="valgrind --tool=callgrind --dump-instr=yes --collect-jumps=yes -v"
alias VALGRINDTHREAD="valgrind --tool=helgrind -v --time-stamp=no --track-fds=no --vgdb-error=0"
alias MASSIF="valgrind --tool=massif --smc-check=all --trace-children=yes --pages-as-heap=yes --detailed-freq=100 --massif-out-file=valgrind_massif.out"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[git:\1]/'
}

parse_svn_url() {
    LANGUAGE=en svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}

parse_svn_repository_root() {
    LANGUAGE=en svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g'| egrep -o '(TAGS|BRANCHES)/[^/]+|TRUNK' | egrep -o '[^/]+$' | awk '{print " [svn:"$1"]" }'
}

# set a fancy prompt
#PS1="[\t]\[\e[1;32m\]\u\[\e[0m\]@\[\e[0;35m\]\h\[\e[0m\]:\[\e[1;31m\]\w\[\033[32m\]\$(parse_git_branch)\$(parse_svn_branch)\[\e[0m\]\$ "
PS1="\[\e[1;32m\]\u\[\e[0m\]@\[\e[0;35m\]\h\[\e[0m\]:\[\e[1;30m\]\w\[\033[32m\]\$(parse_git_branch)\$(parse_svn_branch)\[\e[0m\]\$ "

alias caco="python -m pycalib.scm.pySCMCheckout" 
alias cacpl="python -m pycalib.scm.pySCMCompile" 
alias cast="python -m pycalib.scm.pySCMStatus" 


TERM=xterm-256color 

function cvsdiff() { cvs -q diff $@ | colordiff; }
