autoload -Uz compinit && compinit

# plugins
ZPLUGINDIR=$HOME/.zsh/plugins

if [[ ! -d $ZPLUGINDIR/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZPLUGINDIR/zsh-autosuggestions
fi
source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

if [[ ! -d $ZPLUGINDIR/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting/ $ZPLUGINDIR/zsh-syntax-highlighting
fi
source $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

if [[ ! -d $ZPLUGINDIR/zsh-you-should-use ]]; then
    git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZPLUGINDIR/zsh-you-should-use
fi
source $ZPLUGINDIR/zsh-you-should-use/zsh-you-should-use.plugin.zsh

if [[ ! -d $ZPLUGINDIR/git ]]; then
    mkdir -p $ZPLUGINDIR/git
    curl -o $ZPLUGINDIR/git/git.plugin.zsh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
fi
source $ZPLUGINDIR/git/git.plugin.zsh

# services
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# pnpm
export PNPM_HOME="/home/v4n/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# gpg
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# options
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# env
export EDITOR='vim'
export PAGES='less'
export BROWSER='firefox'
export TERMCMD='kitty' 

# binds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept

# file aliases
alias hconf='cd ~/.config/hypr'
alias hconff='cd ~/.config/hypr/hyprland'
alias hconfs='cd ~/.config/hypr/scripts'
alias kconf='$EDITOR ~/.config/kitty/kitty.conf'
alias wconf='cd ~/.config/waybar'
alias zshrc='$EDITOR ~/.zshrc'

# aliases
alias ls='ls --color'
alias grep='grep --color'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias md='mkdir -p'
alias rd='sudo rm -r'
alias d='dirs -v | head -n 10'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias untar='tar -xvzf'
alias v='$EDITOR'
alias bon="systemctl start bluetooth.service"
alias boff="systemctl stop bluetooth.service"

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
zstyle ':completion:*' menu select

