PROMPT='%c %# '
autoload -U compinit
compinit -u
alias cdt='cd test3/test/'
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/| /g'"

# Docker
alias d='docker'
alias dc='docker compose'
alias dcw='docker compose exec web'
alias dca='docker compose exec app'
alias dcwb='docker compose exec app bundle exec'
alias dcab='docker compose exec app bundle exec'

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'
#alias hub-pr="hub pull-request | open"
#alias git="hub"
alias ping-loop="while true; do ping www.google.com; sleep 3; done;"
alias gommit="git commit"
alias tag-gen="ripper-tags -e -R -f TAGS"
alias h="heroku"

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lv="less"

alias e="emacs -nw"
alias g="git"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
#alias gs="git status"
alias gd="git diff"
alias gl="git log --pretty='format:%Cblue[%ad] %Cgreen%an %Creset%s' --date=short"
alias gr="git remote -v"
alias gus="git update-index --skip-worktree"
alias guns="git update-index --no-skip-worktree"

typeset -U path PATH

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(mise activate zsh)"

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi


# Chrome DevTools MCP alias
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-debug-profile'

