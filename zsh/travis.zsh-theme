# ZSH Theme

function ruby_info_for_prompt {
  if [[ -s "~/.rvm/bin/rvm-prompt" ]]; then
    ruby_version=$(~/.rvm/bin/rvm-prompt i v g)
  fi

  if [[ -s $(brew --prefix asdf) ]]; then
    ruby_version=${$(asdf current ruby)[2]}
  fi

  if [ -n "$ruby_version" ]; then
    echo "[ruby-$ruby_version]"
  fi
}

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPS1=%{$(echotc UP 1)%}%{$fg[magenta]%}[${timer_show}s]%{$reset_color%}%{$(echotc DO 1)%}
    unset timer
  fi
}

local user_host='%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}'
local ruby_prompt=' %{$fg[yellow]%}$(ruby_info_for_prompt)%{$reset_color%}'
local current_dir=':%~'
local git_radar='$(git-radar --zsh)%{$reset_color%}'

export KUBE_PS1_PREFIX=' ['
export KUBE_PS1_SUFFIX=']'
export KUBE_PS1_SEPARATOR=''
export KUBE_PS1_SYMBOL_USE_IMG=true
export KUBE_PS1_SYMBOL_PADDING=true
export KUBE_PS1_NS_ENABLE=false
export KUBE_PS1_CTX_COLOR=blue

PROMPT="
┌[${user_host}]${ruby_prompt}$(kube_ps1)${current_dir}${git_radar}
└[%B%{$fg[blue]%}$%{$reset_color%}%b] "
