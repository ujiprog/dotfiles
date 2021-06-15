source ~/.bash_env
alias v='vim'
alias nv='nvim'
alias vf='vim ~/.config/fish/config.fish'

alias sf='source ~/.config/fish/config.fish'
alias pc='pbcopy <'
alias l='ls -ltr'
alias la='ls -a'
alias ll='ls -l'
alias p='python3'
alias pip='pip3'

# git
alias g='git'
alias gs='git status -sb'
alias gco='git checkout'
alias gp='git pull'
alias gd='git diff'
alias gl='git log --graph --date=short'
alias ga='git add'
alias gc='git commit -m'

# docker
alias dk='docker'
alias dc='docker-compose'
alias dcp='docker-compose ps'

# rails
alias ra='bin/rails'
alias ras='bin/rails s'
alias rac='bin/rails c'
alias rar='bin/rails routes'
alias ram='bin/rails db:migrate'
alias rasp='bin/rspec'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cd dir by fzf
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# git checkout by fzf
fch() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# git remote checkout by fzf
fchr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# docker exec bash by fzf
dbash() {
  local name
  name=$(docker ps --format "{{.Names}}" | fzf)
  docker exec -it $name bash
}
