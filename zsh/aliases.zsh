# Easier navigation: .., ..., ...., .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

##### Shortcuts #####
# Navigation
alias d="cd ~/Documents/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="$PROJECTS"

# Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# Editors
alias e='emacs -nw'

##### Utilities #####
# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Trash/rm - use trash instead of rm on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias rm='trash'
fi

# Reload the terminal profile
alias reload="source ~/.zshrc"

# Modify my dotfiles in my editor
alias dotfiles="$EDITOR $DOTFILES"
