#   Set Paths
#   Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
#   ------------------------------------------------------------
#   Ensure user-installed binaries take precedence by listing in reverse order
export GOPATH=/Users/swarren/Code/GO
export GEM_HOME=$HOME/.gem
PATH="/Applications/PhpStorm EAP.app/Contents/MacOS:$PATH"
PATH=$GOPATH/bin:$PATH
PATH=$HOME/bin:$PATH
PATH=$GEM_HOME/bin:$PATH
PATH=~/.yarn/bin:$PATH
PATH=~/.composer/vendor/bin:$PATH
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

test -f ~/.bashrc && source ~/.bashrc

