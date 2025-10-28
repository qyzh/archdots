# Enable Powerlevel10k instant prompt for faster startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================
HISTFILE=~/.histfile
HISTSIZE=10000              # Increased from 1000
SAVEHIST=10000              # Increased from 1000
setopt HIST_IGNORE_ALL_DUPS # Don't save duplicate commands
setopt HIST_IGNORE_SPACE    # Don't save commands starting with space
setopt HIST_SAVE_NO_DUPS    # Don't write duplicate entries to history
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from history
setopt SHARE_HISTORY        # Share history between sessions
setopt INC_APPEND_HISTORY   # Write to history immediately

# =============================================================================
# ZSH OPTIONS
# =============================================================================
bindkey -e                  # Emacs keybindings
setopt AUTO_CD              # Type directory name to cd
setopt AUTO_PUSHD           # Make cd push old directory to stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt CORRECT              # Suggest command corrections
setopt COMPLETE_IN_WORD     # Complete from both ends of word
setopt ALWAYS_TO_END        # Move cursor to end after completion

# =============================================================================
# COMPLETION SYSTEM
# =============================================================================
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit

# Only regenerate compdump once a day for faster startup
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Enhanced completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colorful completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'

# =============================================================================
# PLUGINS
# =============================================================================
# Load zsh-autosuggestions
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting (must be last)
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions configuration
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# =============================================================================
# POWERLEVEL10K THEME
# =============================================================================
# Try multiple possible locations
if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# Load p10k configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =============================================================================
# PATH CONFIGURATION
# =============================================================================
# Create unique PATH to avoid duplicates
typeset -U path
path=(
  $HOME/.local/bin
  $HOME/.bun/bin
  $HOME/.opencode/bin
  $path
)
export PATH

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================
export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"        # Set default editor
export VISUAL="nvim"        # Set visual editor

# =============================================================================
# FZF CONFIGURATION
# =============================================================================
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
  
  # FZF settings
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}' 2>/dev/null"
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# =============================================================================
# ZOXIDE CONFIGURATION
# =============================================================================
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# =============================================================================
# DIRENV CONFIGURATION
# =============================================================================
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# =============================================================================
# ALIASES
# =============================================================================
# EC2 Management
alias ec2-start='~/.local/bin/ec2-start'
alias ec2-stop='~/.local/bin/ec2-stop'

# Modern tool replacements
if command -v eza &> /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons'
  alias l='eza -lah --icons --group-directories-first'
else
  alias ls='ls --color=auto'
  alias ll='ls -lAh'
  alias la='ls -A'
  alias l='ls -CF'
fi

if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'  # bat with pager
fi

if command -v rg &> /dev/null; then
  alias grep='rg'
else
  alias grep='grep --color=auto'
fi

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# Note: Use 'z' for zoxide, 'cd' still works normally
# Example: z dots, z downloads, zi (interactive)

# Safety
alias mv='mv -i'            # Confirm before overwriting
alias cp='cp -i'            # Confirm before overwriting
alias rm='rm -i'            # Confirm before deleting

# System info
alias df='df -h'            # Human readable sizes
alias free='free -h'        # Human readable sizes
alias du='du -h'            # Human readable sizes

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gpl='git pull'

# Quick edits
alias zshconfig='$EDITOR ~/.zshrc'
alias nvimconfig='$EDITOR ~/.config/nvim/init.lua'
alias reload='source ~/.zshrc'

# =============================================================================
# EXTERNAL COMPLETIONS
# =============================================================================
# Bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# =============================================================================
# STARTUP
# =============================================================================
clear && fastfetch
