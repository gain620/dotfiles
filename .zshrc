if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# Homebrew
# ============================================
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ============================================
# Default editor (neovim)
# ============================================
export EDITOR="nvim"
export VISUAL="nvim"

# ============================================
# pyenv (+ virtualenv)
# ============================================
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# ============================================
# nvm
# ============================================
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# ============================================
# Go
# ============================================
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# ============================================
# GoLand
# ============================================
export PATH="$PATH:/Applications/GoLand.app/Contents/MacOS"

# ============================================
# labctl (iximiuz)
# ============================================
export PATH="$PATH:$HOME/.iximiuz/labctl/bin"

# ============================================
# History
# ============================================
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY

# ============================================
# if overwrite is needed use >|
# ============================================
setopt NO_CLOBBER

# ============================================
# Completion
# ============================================
autoload -Uz compinit && compinit

# kubectl / helm / gh completion (if exists)
command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
command -v helm    >/dev/null 2>&1 && source <(helm completion zsh)
command -v gh      >/dev/null 2>&1 && eval "$(gh completion -s zsh)"

# uv completion
command -v uv      >/dev/null 2>&1 && eval "$(uv generate-shell-completion zsh)"
command -v uvx     >/dev/null 2>&1 && eval "$(uvx --generate-shell-completion zsh)"

# ============================================
# Aliases
# ============================================
# Editor
alias v='nvim'
alias vi='nvim'

# kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kctx='kubectl config current-context'
alias kns='kubectl config view --minify -o jsonpath="{..namespace}"'

# git
alias gs='git status'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'
alias gp='git pull'

# docker
alias dps='docker ps'
alias dpsa='docker ps -a'

# eza (modern ls replacement)
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -lah --icons=auto --git --group-directories-first --time-style=long-iso'
alias la='eza -a --icons=auto --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto --git-ignore'
alias llt='eza -lah --tree --level=2 --icons=auto --git --git-ignore'

# bat
alias cat='bat --paging=never'
alias less='bat'

alias vi='nvim'
alias vim='nvim'
alias cl='clear'

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(starship init zsh)"

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
