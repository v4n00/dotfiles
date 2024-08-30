export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# binds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept

# aliases
alias hconf='cd ~/.config/hypr'
alias hconff='cd ~/.config/hypr/hyprland'
alias hconfs='cd ~/.config/hypr/scripts'
alias kconf='vim ~/.config/kitty/kitty.conf'
alias wconf='cd ~/.config/waybar'
alias zshrc='vim ~/.zshrc'
alias nmcheat='cat ~/Documents/nmcheat.md'

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
