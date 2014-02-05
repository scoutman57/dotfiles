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
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

    #   Add color to terminal
    #   (this is all commented out as I use Mac Terminal Profiles)
    #   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
    #   ------------------------------------------------------------
    #   export CLICOLOR=1
    #   export LSCOLORS=ExFxBxDxCxegedabagacad

    # Set Colors
    bold=$(tput -Txterm bold)
    reset=$(tput -Txterm sgr0)
    NO_COLOR="\[\033[00m\]"
    GREEN="\[\033[0;32m\]"
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    LIGHT_CYAN="\[\033[0;36m\]"

    #   ---------------------------------------
    # Set up a colorful command prompt,
    # with the current git branch and the current directory.
    #   ---------------------------------------
    # export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
    # export PS2="| => "
    
    # For a command prompt display like:
    # JDoe@JDoes-MacBook-Pro Jira-1327 ~/Code/MyProject $
    #export PS1="\[\e[1;31m\]\u\[\e[0;37m\]@\[\e[1;32m\]\h\[\e[1;36m\] \`git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/$/ /'\`\[\e[1;34m\]\w \[\e[1;35m\]\$ \[\e[0;37m\]"
    
    # For a command prompt display like:
    # JDoe@JDoes-MacBook-Pro[~/Code/MyProject](git:Jira-1327)
    # $
    export PS1='\e[1;31m\]\u\[\e[0;37m\]@\[\e[1;32m\]\h\[$black\][\[\e[1;34m\]\w\[$black\]]\[\e[1;36m\]$(__vcs_name)\[$reset\]\n\[$reset\]\$ '

    # For a command prompt display like:
    # [JDoe@JDoes-MacBook-Pro:~/Code/MyProject (git:Jira-1327)]$
    export PS1="[$LIGHT_CYAN\u$RED@\h$NO_COLOR:$YELLOW\w$NO_COLOR $GREEN\$(__vcs_name)$NO_COLOR)]$ "

    #   Set architecture flags
     export ARCHFLAGS="-arch x86_64"

    #   Set Paths
    #   ------------------------------------------------------------
    # Ensure user-installed binaries take precedence
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/git/bin:/sw/bin:/usr/local/bin:/usr/local:/usr/local/sbin:$PATH"

    # Conditionally add some things to $PATH, if they exist.
    for d in ~/bin ~/usr/bin ; do
      if test -d "$d" && ! echo "$PATH" | grep -q $(readlink -e "$d") ; then
        PATH="$d":"$PATH"
      fi
    done

    # Conditionally add some things to $LD_LIBRARY_PATH (shared libs).
    for d in ~/usr/lib ; do
      if test -d "$d" ; then
        LD_LIBRARY_PATH="$d":"$LD_LIBRARY_PATH"
      fi
    done
    export LD_LIBRARY_PATH


    #   Set Default Editor (change 'Nano' to the editor of your choice)
    #   ------------------------------------------------------------
        export EDITOR=/usr/bin/vi
        
        # opens file or folder with sublime
        alias sublime='open -a "Sublime Text"'

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

    # iTerm2 custom title on each tab
    export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'

    # reloads the prompt, usefull to take new modifications into account
    alias reload="source ~/.bash_profile"

    # grabs the latest .bash_profile file and reloads the prompt
    alias updatebashrc="curl https://raw.github.com/w2pc/dotfiles/master/.bashrc > ~/.bashrc && reload"

    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation
    cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit='subl'                           # edit:         Opens any file in sublime editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias ~="cd ~"                              # ~:            Go Home
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
    trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
    ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
    alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

    #   lr:  Full Recursive Directory Listing
    #   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

    #   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
    #           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
    #   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

    #   showa: to remind yourself of an alias (given some part of it)
    #   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

    function sshKeyGen(){
        echo "What's the name of the Key (no spaced please) ? ";
        read name;

        echo "What's the email associated with it? ";
        read email;

        ssh-keygen -t rsa -f ~/.ssh/id_rsa_$name -C "$email";
        pbcopy < ~/.ssh/id_rsa_$name.pub;

        echo "SSH Public Key copied to your clipboard";
    }


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

    zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
    #alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
    #alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
    #alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
    #alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

    #   cdf:  'Cd's to frontmost window of MacOS Finder
    #   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<"    EOT"
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
        EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

    #   extract:  Extract most know archives with one command
    #   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

    alias qfind="find . -name "                 # qfind:    Quickly search for file
    ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
    ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
    ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

    #   spotlight: Search for a file using MacOS Spotlight's metadata
    #   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

    #   findPid: find out the pid of a specified process
    #   -----------------------------------------------------
    #       Note that the command name can be specified via a regex
    #       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
    #       Without the 'sudo' it will only find processes of the current user
    #   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

    #   memHogsTop, memHogsPs:  Find memory hogs
    #   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

    #   cpuHogs:  Find CPU hogs
    #   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

    #   topForever:  Continual 'top' listing (every 10 seconds)
    #   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

    #   ttop:  Recommended 'top' invocation to minimize resources
    #   ------------------------------------------------------------
    #       Taken from this macosxhints article
    #       http://www.macosxhints.com/article.php?story=20060816123853639
    #   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

    #   my_ps: List processes owned by my user:
    #   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

    alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
    alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
    alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
    alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
    alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
    alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
    alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
    alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
    alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
    alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

    #   ii:  display useful host related informaton
    #   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

    alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

    #   cleanup:  Recursively delete .DS_Store & Thumbs.db files
    #   -------------------------------------------------------------------
    alias cleanup="find . -name '*.DS_Store' -type f -ls -delete && find . -name 'Thumbs.db' -type f -ls -delete"

    #   finderShowHidden:   Show hidden files in Finder
    #   finderHideHidden:   Hide hidden files in Finder
    #   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder AppleShowAllFiles -bool YES; killall -HUP Finder'
    alias finderHideHidden='defaults write com.apple.finder AppleShowAllFiles -bool NO; killall -HUP Finder'

    #   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
    #   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

    #    screensaverDesktop: Run a screensaver on the Desktop
    #   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

    alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
    alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
    alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
    alias tailLogs='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
    alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
    httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

    #   httpDebug:  Download a web page and show info on what took time
    #   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }


#   ---------------------------------------
#   9.  REMINDERS & NOTES
#   ---------------------------------------

    #   remove_disk: spin down unneeded disk
    #   ---------------------------------------
    #   diskutil eject /dev/disk1s3

    #   to change the password on an encrypted disk image:
    #   ---------------------------------------
    #   hdiutil chpass /path/to/the/diskimage

    #   to mount a read-only disk image as read-write:
    #   ---------------------------------------
    #   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

    #   mounting a removable drive (of type msdos or hfs)
    #   ---------------------------------------
    #   mkdir /Volumes/Foo
    #   ls /dev/disk*   to find out the device to use in the mount command)
    #   mount -t msdos /dev/disk1s1 /Volumes/Foo
    #   mount -t hfs /dev/disk1s1 /Volumes/Foo

    #   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
    #   ---------------------------------------
    #   e.g.: mkfile 10m 10MB.dat
    #   e.g.: hdiutil create -size 10m 10MB.dmg
    #   the above create files that are almost all zeros - if random bytes are desired
    #   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

#   ---------------------------------------
#   10.  VERSION CONTROL SYSTEMS
#   ---------------------------------------   

    # curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
    source ~/.git-prompt.sh

        # Git - compact, colorized git log
    alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    # Git - Visualize git log
    alias lg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

    # Lets figure out what out what type of source control we are using.
    __has_parent_dir () {
       # Utility function so we can test for things like .git/.hg without firing
       # up a separate process
       test -d "$1" && return 0;

       current="."
       while [ ! "$current" -ef "$current/.." ]; do
           if [ -d "$current/$1" ]; then
               return 0;
           fi
           current="$current/..";
       done

       return 1;
    }

    __vcs_name() {
       if [ -d .svn ]; then
           echo "-[svn]";
       elif __has_parent_dir ".git"; then
           echo "($(__git_ps1 'git:%s'))";
       elif __has_parent_dir ".hg"; then
           echo "(hg:$(hg branch))"
       fi
    }

    #   GIT Functions
    #   ---------------------------------------
    # git commit, and prefix/prepend the current branch name to the message.
    gcm()
    {
        if test "$#" -ne 1 ; then
            echo "Usage: gcm 'commit message...'" 1>&2
            return 127
        fi
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test -z "$branch" ; then
            echo "You are not inside of a git repository, or HEAD is detached." 1>&2
            return 1
        fi
        message="$1"
        # trim whitespace
        message=$(echo "$message" | sed 's/^[ \t]*//;s/[ \t]*$//')
        if ! echo "$message" | grep -Eq "^$branch" ; then
            message="$branch: $message"
        fi
        echo "git commit -m '$message'"
        git commit -m "'$message'"
    }
    
    # git push pub <current-branch>
    gpp()
    {
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test -z "$branch" ; then
            echo "You are not inside of a git repository, or HEAD is detached." 1>&2
            return 1
        fi
        echo "git push pub $branch"
        git push pub "$branch"
    }

#   ---------------------------------------
#   Included dotfiles for specific servers
#   or for sensitive information
#   ---------------------------------------

    source "/Users/$(whoami)/Google Drive/.private"
