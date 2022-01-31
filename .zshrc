#########################################################################################
################################### p10k ################################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
else
  [[ ! -f ~/.config/zsh/.p10k-portable.zsh ]] || source ~/.config/zsh/.p10k-portable.zsh
fi
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  source ~/.config/zsh/.p10k-v.zsh
fi
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


#########################################################################################
################################## Environment ##########################################
if [[ -z "$XDG_DATA_HOME" ]]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$XDG_DATA_DIRS" ]]; then
  export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

if [[ -z "$XDG_CONFIG_DIRS" ]]; then
  export XDG_CONFIG_DIRS="/etc/xdg"
else
  export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
fi
fpath=("$XDG_CONFIG_HOME/zsh/completion" $fpath)
#export TERM="xterm-256color"

SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
source ~/.config/openbox/environment


#########################################################################################
################################### Settings ############################################
HISTFILE=~/.cache/zsh-histfile
HISTSIZE=2500
SAVEHIST=$HISTSIZE

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' original true
zstyle ':completion:*' menu select

zstyle :compinstall filename '~/.config/zsh/.zshrc'

bindkey -v
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey '^P' autosuggest-accept
autoload -Uz compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-functions
source ~/.config/zsh/zsh-aliases
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
compinit

setopt hist_ignore_all_dups
setopt extendedglob autocd interactive_comments prompt_subst
unsetopt nomatch notify beep
