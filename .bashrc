# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  ***NOTE*** for OSX you will need the following installed vi homebrew
#  brew install coreutils
#  brew install gnu-sed --default-names
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Reminders & Notes
#  10.  Version Control System
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------
    #   Set Paths
    #   ------------------------------------------------------------
    # Add bash-completion if installed from homebrew
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    #   Set default blocksize for ls, df, du
    #   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
    #   ------------------------------------------------------------
        export BLOCKSIZE=1k

    # Configure bash command history.
        export HISTSIZE=10000 # current session
        export HISTFILESIZE=10000 # file; shared between all sessions
        export HISTCONTROL=ignoreboth # don't save duplicates
        export HISTIGNORE=ls:ll:history:bg:fg:ping:pwd
        export HISTTIMEFORMAT='%F %T ' # prefix each line with a timestamp
        shopt -s cmdhist # one command per line
        shopt -s histappend # append instead of overwrite when session ends
        #export PROMPT_COMMAND='history -a' # store history immediately

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------
    # Detect which `ls` flavor is in use
    if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    else # OS X `ls`
    colorflag="-G"
    fi

    #   Add color to terminal
    #   (this is all commented out as I use Mac Terminal Profiles)
    #   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
    #   ------------------------------------------------------------
       #export CLICOLOR=1
       #export LSCOLORS=ExFxBxDxCxegedabagacad
    # iTerm2 custom title on each tab
    #export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'

    # reloads the prompt, usefull to take new modifications into account
    alias reload="source ~/.bashrc"

    # grabs the latest .bash_profile file and reloads the prompt
    alias updatebashrc="curl https://raw.github.com/scoutman57/dotfiles/master/.bashrc > ~/.bashrc && reload"
    
    #   ---------------------------------------
#   10.  VERSION CONTROL SYSTEMS
#   ---------------------------------------
    # curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.sh
    source ~/.git-completion.sh

    function parse_git_dirty() {
      [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
    }

    function parse_git_branch() {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
    }

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
    for file in ~/.{bash_prompt,exports,aliases,functions,extra}; do
      [ -r "$file" ] && source "$file"
    done
    unset file

#   ---------------------------------------
#   Included dotfiles for specific servers
#   or for sensitive information
#   ---------------------------------------
  PRIVATE_DIRECTORY="/Users/$(whoami)/Google Drive/.dotfiles/"
  if [ -d "$PRIVATE_DIRECTORY" ]; then
    for i in "$PRIVATE_DIRECTORY"*.aliases; do . "$i"; done
  fi
