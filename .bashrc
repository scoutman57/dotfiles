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
    alias path='echo -e ${PATH//:/\\n}'

    # Add bash-completion if installed from homebrew
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    #   Set ngrok VPN (Secure tunnels to localhost)
    #   ------------------------------------------------------------
        alias ngrok='/Applications/ngrok'

    #   Set Default Editor (change 'Sublime Text' to the editor of your choice)
    #   ------------------------------------------------------------
        #export EDITOR=/usr/bin/vi
        #export EDITOR='atom -w'

        # opens file or folder with sublime
        alias sublime='open -a "Sublime Text"'
        # opens file or folder with atom.io
        alias atom='open -a "Atom"'

    #   Set Default Diff (change 'phpstorm' to the editor of your choice)
    #   ------------------------------------------------------------
        # opens file or folder with the default diff tool
        # diff <path to file1> <path to file2>
        psdiff()
        {
            phpstorm diff $(realpath "$1") $(realpath "$2")
            echo "Diff: $(realpath $1) $(realpath $2) $(realpath $3) $(realpath $4)"
        }

    #   Set Default Merge (change 'phpstorm' to the editor of your choice)
    #   ------------------------------------------------------------
        # opens file with the default merge tool
        # merge <path to file1> <path to file2> <path to file3> <path to output>
        # file3 is the base revision for file1 and file2, file4 (output) is the file to save the merge results in (optional)
        merge()
        {
            phpstorm merge $(realpath "$1") $(realpath "$2") $(realpath "$3") $(realpath "$4")
            echo "Merge: $(realpath $1) $(realpath $2) $(realpath $3) $(realpath $4)"
        }

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

    # Directoy navigation aliases
    alias ls='ls -G'                            # Preferred 'ls' implementation
    alias dir='dir --color=auto'                # Preferred 'dir' implementation
    alias vdir='vdir --color=auto'              # Preferred 'vdir' implementation
    alias grep='grep --color=auto'              # Preferred 'grep' implementation
    alias fgrep='fgrep --color=auto'            # Preferred 'fgrep' implementation
    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation
    alias lsd='ls -l | grep "^d"'               # List only directories
    cd() { builtin cd "$@"; ls ; }              # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit='atom'                           # edit:         Opens any file in atom editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias ~="cd ~"                              # ~:            Go Home
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd() { mkdir -p "$1" && cd "$_" ; }        # mcd:          Makes new Dir and jumps inside
    alias mcd=mcd
    trash() { command mv "$@" ~/.Trash  ; }     # trash:        Moves a file to the MacOS trash
    ql() { qlmanage -p "$*" >& /dev/null ; }    # ql:           Opens any file in MacOS Quicklook Preview
    alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
    alias copy='rsync -a -v --ignore-existing'  # Copy files with rsync if don't already exist
    alias iw='itermocil'
    complete -W "$(itermocil --list)" itermocil

    #   lr:  Full Recursive Directory Listing
    #   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

    #   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
    #           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
    #   --------------------------------------------------------------------
    mans() { man $1 | grep -iC2 --color=always $2 | less ; }

    #   showa: to remind yourself of an alias (given some part of it)
    #   ------------------------------------------------------------
    showa() { /usr/bin/grep --color=always -i -a1 $@ ~/.bashrc | grep -v '^\s*$' | less -FSRXc ; }

    #SSH Key Generation
    sshKeyGen()
    {
        echo "What's the name of the Key (no spaced please)? ";
        read name;

        echo "What's the email associated with it? ";
        read email;

        ssh-keygen -t rsa -f ~/.ssh/id_rsa_$name -C "$email";
        pbcopy < ~/.ssh/id_rsa_$name.pub;

        echo "SSH Public Key copied to your clipboard";
    }

    ssh-copy-id()
    {
        echo "What's the name of the Key (don't include .pub)? ";
        read name;

        echo "What's the ssh host name/ip? ";
        read host;

        cat ~/.ssh/$name.pub | ssh $host "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys" ;
    }
    alias ssh-copy-id=ssh-copy-id

    # The skip command will just add some blank lines. I find this helpful when I have a lot of output from a command, and want to get some visual separation so I can easily spot my last command
    skip()
    {
        NUMBEROFTIMES=5
        if [[ $1 ]]; then
            let NUMBEROFTIMES=$NUMBEROFTIMES*$1
        fi

        for (( i=1; i <= $NUMBEROFTIMES; i++ ))
        do
            printf "\n"
        done
    }

    # lock computer
    alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
    # hibernation and sleep settings
    alias hibernate='sudo pmset -a hibernatemode 25'
    alias sleep='sudo pmset -a hibernatemode 0'
    alias safesleep='sudo pmset -a hibernatemode 3'
    alias smartsleep='sudo pmset -a hibernatemode 2'

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------
    zipf() { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
    #alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
    #alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
    #alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
    #alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

    #   cdf:  'Cd's to frontmost window of MacOS Finder
    #   ------------------------------------------------------
    cdf()
    {
        target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
            if [ "$target" != "" ]; then
                echo "cd to \"$currFolderPath\""
                cd "$target"; pwd
            else
                echo 'No Finder window found' >&2
            fi
    }

    # Open finder at the current location
    alias finder='open -a Finder ./'

    #   extract:  Extract most know archives with one command
    #   ---------------------------------------------------------
    extract()
    {
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
    ff() { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
    ffs() { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
    ffe() { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

    #   spotlight: Search for a file using MacOS Spotlight's metadata
    #   -----------------------------------------------------------
    spotlight() { mdfind "kMDItemDisplayName == '$@'wc" ; }


#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

    #   findPid: find out the pid of a specified process
    #   -----------------------------------------------------
    #       Note that the command name can be specified via a regex
    #       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
    #       Without the 'sudo' it will only find processes of the current user
    #   -----------------------------------------------------
    findPid() { lsof -t -c "$@" ; }
    alias findPid=findPid

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
    alias my_ps=my_ps

    alias h='history'
    alias j='jobs -l'


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
    portInfo() { sudo lsof -i :$1 ; }
    alias portInfo=portInfo                             # checkPort     Get info on connections on port
    alias findPorts='sudo lsof -i -n -P'                # show all Ports
    alias findTCPPorts='sudo lsof -i TCP'               # show all TCP Ports
    alias editDnsmasq='edit /usr/local/etc/dnsmasq.conf'

    #   ii:  display useful host related informaton
    #   -------------------------------------------------------------------
    ii()
    {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------
    alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user
    #   finderShowHidden:   Show hidden files in Finder
    #   finderHideHidden:   Hide hidden files in Finder
    #   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder AppleShowAllFiles -bool YES; killall -HUP Finder'
    alias finderHideHidden='defaults write com.apple.finder AppleShowAllFiles -bool NO; killall -HUP Finder'

    # update system packages
    alias update='brew update && brew upgrade && brew cu && brew cleanup; brew doctor; npm update -g; composer global update'
    alias clean='cleanup; cleanupLS; brew cleanup; '

    #   cleanup:  Recursively delete .DS_Store & Thumbs.db files
    #   -------------------------------------------------------------------
    alias cleanup="find . -name '*.DS_Store' -type f -ls -delete && find . -name 'Thumbs.db' -type f -ls -delete && find . -name 'desktop.ini' -type f -ls -delete"
    #   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
    #   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

    #    screensaverDesktop: Run a screensaver on the Desktop
    #   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

    alias grey-grep="GREP_COLOR='1;30' grep -E --color=always --line-buffered"
    alias red-grep="GREP_COLOR='1;31' grep -E --color=always --line-buffered"
    alias green-grep="GREP_COLOR='1;32' grep -E --color=always --line-buffered"
    alias yellow-grep="GREP_COLOR='1;33' grep -E --color=always --line-buffered"
    alias cyan-grep="GREP_COLOR='1;36' grep -E --color=always --line-buffered"

    alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
    alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
    alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:       Shows apache error logs

    alias nginxLogs='tail -f /usr/local/var/log/nginx/error.log'
    alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file

    alias phpLogs='tail -f /usr/local/var/log/php-fpm.log'

    alias logs='tail -f /usr/local/var/log/php-fpm.log /usr/local/var/log/nginx/error.log /usr/local/var/log/redis.log /usr/local/var/log/mongodb/*.log /usr/local/var/log/rabbitmq/*.log'
    #sudo tail -f /var/log/disco/*log /var/log/apache2/error.log
    httpHeaders() { /usr/bin/curl -I -L $@ ; }              # httpHeaders:      Grabs headers from web page

    #   httpDebug:  Download a web page and show info on what took time
    #   -------------------------------------------------------------------
    httpDebug() { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

    alias pgsqlConf='edit /usr/local/var/postgres/postgresql.conf'
    #alias pgsqlLogs='tail -f /usr/local/var/postgres/pg_log/postgresql.log'
    alias pgsqlLogs='tail -f /usr/local/var/log/postgresql.log'
    # Starts a php server
    phps() { php -S localhost:$1 ; }
    alias phps=phps
    alias art='php artisan'
    alias tinker='php artisan tinker'
    alias phpunit='vendor/phpunit/phpunit/phpunit'

    function new() {
  	  if [ "$1" == "laravel" ]; then
  	      composer create-project --prefer-dist laravel/laravel $2
  	  elif [ "$1" == "symfony" ]; then
  	      symfony new $2
        elif [ "$1" == "lumen" ]; then
          composer create-project --prefer-dist laravel/lumen $2
      elif [ "$1" == "laravelcrud" ]; then
          git clone -b 5.3 git@github.com:InfyOmLabs/adminlte-generator.git $2;
          cd $1;
          composer install;
      elif [ "$1" == "meteor" ]; then
          meteor create $2
          cd $1
          meteor
  	  fi
  	}

    alias killphp='killall -KILL php-fpm; killall -KILL php'

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
    # curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.sh
    source ~/.git-completion.sh

    function parse_git_dirty() {
      [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
    }

    function parse_git_branch() {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
    }

    # ----------------------
    # Git Aliases
    # ----------------------
    alias g='git'
    alias ga='git add'
    alias gb='git branch'
    # Git - delete a local branch
    alias gbd='git branch -D'
    # Git - delete a remote branch
    alias gbdr='git push origin --delete'
    alias gc='git commit'
    alias gcm='git commit -m'
    alias gco='git checkout'
    alias gcob='git checkout -b'
    alias gcom='git checkout master'
    alias gcr='git clone'
    alias gd='git diff'
    alias gdh='git diff HEAD'
    alias gi='git init'
    # Git - compact, colorized git log
    alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %ad) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all"
    # Git - Visualize git log
    alias glg='git log --graph --full-history --oneline --decorate --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
    alias gm='git merge --no-ff'
    alias gpl='git pull'
    alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'
    alias gss='git status -s'
    alias gst='git stash'
    alias gstl='git stash list'
    alias gstp='git stash pop'
    alias gstd='git stash drop'

    # ----------------------
    # Git Functions
    # ----------------------
    #find all origin urls for sub folders
    alias fgo='cd ~/Code && find . -name "config"  -type f  -maxdepth 4 | xargs grep "url" --color=auto'
    #update all git repos in subfolders
    alias uap="cd ~/Code && find . -name .git -type d -maxdepth 2 | xargs -n1 -P1 -I% bash -c 'git --git-dir=% remote get-url origin; git --git-dir=% --work-tree=%/.. fetch origin;'"
    # Git log find by commit message
    glf() { git log --all --grep="$1" ; }

    # delete the remote branch
    #gbdr() { git push origin --delete "$1" ; }

    # git commit, and prefix/prepend the current branch name to the message.
    gcmb()
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
        git commit -m "$message"
    }

    # git push <current-branch>
    gpo()
    {
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test -z "$branch" ; then
            echo "You are not inside of a git repository, or HEAD is detached." 1>&2
            return 1
        fi
        echo "git push origin $branch"
        git push origin "$branch"
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
    for i in "$PRIVATE_DIRECTORY"*.bash; do . "$i"; done
  fi
