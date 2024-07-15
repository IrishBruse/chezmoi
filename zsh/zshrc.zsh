eval "$(oh-my-posh init zsh --config ~/dotfiles/zsh/oh-my-posh.yaml)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

autoload -Uz compinit
compinit

source "${ZINIT_HOME}/zinit.zsh"

zinit light zpm-zsh/clipboard # pipe to clip
zinit light zsh-users/zsh-autosuggestions  # ghost text completion
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'

source ~/dotfiles/zsh/commands.zsh
source ~/dotfiles/zsh/nvm.zsh

[ -f ~/gp.sh ] && source ~/gp.sh
[ -f ~/secrets.sh ] && source ~/secrets.sh

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
setopt hist_ignore_all_dups
