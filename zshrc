export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"

plugins=(common-aliases
          git
          gitfast
          history-substring-search
          pj
          rails
          zsh-autosuggestions
          zsh-syntax-highlighting)

PROJECT_PATHS=(~/code/) # for the pj plugin
source $ZSH/oh-my-zsh.sh
unalias rm

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="nvim"
export EDITOR="zed --wait"

# rbenv
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Allow running binstubs without `bin/` prefix
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Load aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
