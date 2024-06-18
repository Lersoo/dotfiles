ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"

# Oh-my-zsh plugins
plugins=(git
        gitfast
        common-aliases
        rails
        rake-fast
        pj
        zsh-syntax-highlighting
        history-substring-search)

PROJECT_PATHS=(~/code/) # for the pj plugin
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="nvim"
export EDITOR="zed --wait"

# rbenv
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# pyenv
export PATH="${HOME}/.pyenv/bin:${PATH}"
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Allow running binstubs without `bin/` prefix
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Load aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
