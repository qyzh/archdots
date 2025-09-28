# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


    # Load Zsh completion plugins
    if [[ -f /usr/share/zsh/functions/Completion/Zsh/site-functions/_zsh_autocomplete ]]; then
        source /usr/share/zsh/functions/Completion/Zsh/site-functions/_zsh_autocomplete
    fi

    # Load zsh-autosuggestions
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Load zsh-syntax-highlighting
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Load zsh-completions
    if [[ -d /usr/share/zsh-completions ]]; then
        source /usr/share/zsh/zsh-completion.zsh
    fi

    # Example for zsh-autocomplete: Add real-time completion for commands
    # zstyle ':completion:*:descriptions' format '%F{2}%B%d%f%b'
    # zstyle ':completion:*:messages' format '%F{1}%B%F{220}%d%f%b'



HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '~/.zshrc'
clear && fastfetch
autoload -Uz compinit
compinit

# Alias

# PLUGINS
plugins=(
git
archlinux
kitty
zsh-autosuggestions 
zsh-syntax-highlighting 
fast-syntax-highlighting 
zsh-autocomplete
  )

source ~/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
