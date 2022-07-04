# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# alias settings
# For a full list of active aliases, run `alias`.
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
alias home="cd ~/"
alias fixvim="v ~/.config/nvim/init.vim"
alias dotfiles="cd ~/.dotfiles"
alias sourcezsh="source ~/.zshrc"
alias vim="nvim"
alias v="nvim"
alias c="clear"
alias ls="ls -a"
alias zshcustom="vim $HOME/.oh-my-zsh/custom/my_patches.zsh"

export TERM="xterm-256color"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PGDATABASE=postgres

alias luamake=$HOME/.config/nvim/lua-language-server/3rd/luamake/luamake
