# Custom Aliases for CatchyOS Workspace
# Add your custom aliases here - this file is sourced by .zshrc

# ============================================================================
# FILE SYSTEM ALIASES
# ============================================================================
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ============================================================================
# DOCKER ALIASES
# ============================================================================
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -f'
alias dce='docker-compose exec'
alias dcb='docker-compose build'
alias dcp='docker-compose ps'
alias dci='docker-compose images'
alias dcv='docker-compose version'
alias dcs='docker-compose stop'
alias dck='docker-compose kill'

# Docker general
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dexec='docker exec -it'
alias dlog='docker logs -f'
alias dstats='docker stats'

# ============================================================================
# GIT ALIASES
# ============================================================================
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gl='git log --oneline --graph --decorate --all'
alias gll='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'
alias gm='git merge'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gcl='git clone'
alias grm='git rm'
alias grmc='git rm --cached'
alias gmv='git mv'
alias gshow='git show'
alias gblame='git blame'

# ============================================================================
# DEVELOPMENT TOOLS ALIASES
# ============================================================================
alias code='cursor'
alias vim='nvim'
alias vi='nvim'
alias cat='bat'  # If bat is installed
alias top='htop'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ============================================================================
# SYSTEM & PACKAGE MANAGER ALIASES
# ============================================================================
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias info='pacman -Si'
alias list='pacman -Q'
alias listi='pacman -Qi'
alias orphans='pacman -Qtdq'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# AUR (yay)
alias yupdate='yay -Syu'
alias yinstall='yay -S'
alias yremove='yay -Rns'
alias ysearch='yay -Ss'

# ============================================================================
# NODE.JS / NPM ALIASES
# ============================================================================
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nu='npm uninstall'
alias nud='npm uninstall --save-dev'
alias nup='npm update'
alias nls='npm list'
alias nlsg='npm list -g --depth=0'
alias nr='npm run'
alias nst='npm start'
alias ntest='npm test'
alias nbuild='npm run build'
alias nwatch='npm run watch'
alias ndev='npm run dev'

# Yarn
alias ya='yarn add'
alias yad='yarn add --dev'
alias yu='yarn remove'
alias yup='yarn upgrade'
alias yst='yarn start'
alias ytest='yarn test'
alias ybuild='yarn build'
alias ydev='yarn dev'

# pnpm
alias pni='pnpm install'
alias pna='pnpm add'
alias pnad='pnpm add -D'
alias pnu='pnpm remove'
alias pnup='pnpm update'
alias pnr='pnpm run'
alias pnst='pnpm start'
alias pntest='pnpm test'
alias pnbuild='pnpm build'
alias pndev='pnpm dev'

# ============================================================================
# GO ALIASES
# ============================================================================
alias gob='go build'
alias gor='go run'
alias got='go test'
alias gof='go fmt'
alias gov='go vet'
alias gom='go mod'
alias gomi='go mod init'
alias gomt='go mod tidy'
alias gomd='go mod download'
alias goi='go install'
alias goc='go clean'
alias gog='go get'
alias air='air'  # Live reload

# ============================================================================
# PHP / LARAVEL ALIASES
# ============================================================================
alias pa='php artisan'
alias pam='php artisan migrate'
alias pamf='php artisan migrate:fresh'
alias pams='php artisan migrate:status'
alias pamr='php artisan migrate:rollback'
alias pamrs='php artisan migrate:refresh --seed'
alias pas='php artisan serve'
alias pat='php artisan tinker'
alias pac='php artisan cache:clear'
alias paco='php artisan config:clear'
alias paro='php artisan route:clear'
alias pavi='php artisan view:clear'
alias pacom='composer'
alias pacomi='composer install'
alias pacomu='composer update'
alias pacomr='composer require'
alias pacomrd='composer require --dev'
alias pacomd='composer dump-autoload'

# ============================================================================
# FLUTTER ALIASES
# ============================================================================
alias fl='flutter'
alias flr='flutter run'
alias flrd='flutter run -d'
alias flb='flutter build'
alias flba='flutter build apk'
alias flbi='flutter build ios'
alias flt='flutter test'
alias flc='flutter clean'
alias flg='flutter get'
alias flp='flutter pub'
alias flpi='flutter pub get'
alias flpu='flutter pub upgrade'
alias fld='flutter doctor'
alias fldv='flutter doctor -v'
alias fla='flutter analyze'
alias flfmt='flutter format .'

# ============================================================================
# DATABASE ALIASES
# ============================================================================
alias mysqlc='mysql -u dev_user -pdev_password dev_db'
alias psqlc='psql -U dev_user -d dev_db'
alias redis-cli='redis-cli'

# ============================================================================
# NETWORK ALIASES
# ============================================================================
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias ip='ip -c'
alias ipa='ip addr show'
alias ipr='ip route show'

# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'

# ============================================================================
# PROCESS MANAGEMENT
# ============================================================================
alias psg='ps aux | grep'
alias killp='kill -9'
alias psmem='ps aux | sort -nr -k 4'
alias pscpu='ps aux | sort -nr -k 3'

# ============================================================================
# QUICK NAVIGATION
# ============================================================================
alias dev='cd ~/dev'
alias projects='cd ~/projects'
alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'

# ============================================================================
# CUSTOM ALIASES - ADD YOUR OWN BELOW
# ============================================================================
# Add your custom aliases here:
# alias myalias='my command'

