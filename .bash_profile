#   Set Paths
#   Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
#   ------------------------------------------------------------
# Ensure user-installed binaries take precedence by listing in reverse order
export GEM_HOME=$HOME/.gem

# Go Development
export GOPATH="$HOME/golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

test -d "${GOPATH}" || mkdir "${GOPATH}"

PATH="/Applications/PhpStorm EAP.app/Contents/MacOS:$PATH"

PATH=/usr/local/sbin:$PATH
PATH=$HOME/bin:$PATH
PATH=$GEM_HOME/bin:$PATH
PATH=~/.yarn/bin:$PATH
PATH=~/.composer/vendor/bin:$PATH
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

test -f ~/.bashrc && source ~/.bashrc
