autoload -Uz compinit && compinit

# plugins
ZPLUGINDIR=$HOME/.zsh/plugins
[[ ! -d $ZPLUGINDIR/zsh-autosuggestions ]] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZPLUGINDIR/zsh-autosuggestions; source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
[[ ! -d $ZPLUGINDIR/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting/ $ZPLUGINDIR/zsh-syntax-highlighting; source $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
[[ ! -d $ZPLUGINDIR/zsh-you-should-use ]] && git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZPLUGINDIR/zsh-you-should-use; source $ZPLUGINDIR/zsh-you-should-use/zsh-you-should-use.plugin.zsh
[[ ! -f $ZPLUGINDIR/git.plugin.zsh ]] && curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh -o $ZPLUGINDIR/git.plugin.zsh; source $ZPLUGINDIR/git.plugin.zsh

# services
eval "$(starship init zsh)"
eval "$(keychain --eval --quiet)"

# options
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# env
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export PAGES='less'
export BROWSER='waterfox'
export TERMCMD='kitty' 

# binds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept
bindkey -e

# aliases
alias hconf='cd ~/.config/hypr'
alias hconff='cd ~/.config/hypr/hyprland'
alias hconfs='cd ~/.config/hypr/scripts'
alias wconf='cd ~/.config/waybar'
alias sapps='cd ~/.local/share/Steam/steamapps/common'
alias ls='ls --color'
alias l='ls -lah'
alias ll='ls -lh'
alias lt='ls -lhtr'
alias grep='grep --color'
alias history='history 1'
alias md='mkdir -p'
alias rd='rm -r'
alias v='$EDITOR'
alias vim='$EDITOR'
alias sudo='sudo '
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
