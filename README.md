# Setup Workspace CatchyOS

Script setup otomatis untuk development environment di Arch Linux.

## 🚀 Quick Start

```bash
chmod +x install.sh
./install.sh
```

## 📁 Struktur Project

```
setup-workspace-catchyOS/
├── install.sh                  # Script utama (jalankan ini saja)
├── packages/
│   ├── pacman-list.txt         # Daftar paket native
│   └── aur-list.txt            # Daftar paket AUR
├── configs/
│   ├── .zshrc                  # Config Zsh
│   ├── .gitconfig              # Config Git (edit user info!)
│   ├── aliases.zsh             # Custom aliases (bisa ditambah sendiri)
│   ├── starship.toml           # Config Starship prompt
│   └── mise.toml               # Config version manager
├── docker-stack/
│   ├── docker-compose.yml      # Services: MySQL, PG, Redis, RabbitMQ, dll
│   └── control.sh              # Script kontrol services
├── scripts/
│   ├── setup-android.sh        # Setup Android/KVM/Flutter
│   ├── setup-php-laravel.sh    # Setup PHP extensions untuk Laravel
│   ├── setup-ssh-vpn.sh        # Setup SSH & VPN
│   └── git-clone-all.sh        # Clone banyak repo sekaligus
└── repos.txt                   # List repository untuk git-clone-all.sh
```

## 📦 Package yang Terinstall

### Native (pacman)
- Git, Zsh, Docker, Docker Compose
- Development tools (vim, neovim, curl, wget, dll)
- PHP dengan extensions untuk Laravel
- Build tools (cmake, make, gcc, clang)

### AUR
- Cursor (code editor)
- Postman
- Figma Linux
- Android Studio
- Flutter
- DBeaver CE (database GUI)

### Via Mise
- Node.js, Go, PHP, Java, Python, Rust
- Air (Go live reload)
- GolangCI-Lint
- Composer
- Flutter

## 🔧 Setup Setelah Install

1. **Edit Git Config**
   ```bash
   nano ~/.gitconfig
   # Ganti "Your Name" dan email dengan data kamu
   ```

2. **Tambah Custom Aliases**
   ```bash
   nano ~/.aliases.zsh
   # Tambahkan alias custom di bagian bawah file
   ```

3. **Setup Repository List untuk Git Clone**
   ```bash
   nano repos.txt
   # Tambahkan repository GitHub kamu (satu per baris)
   # Format: user/repo atau full URL
   ```

4. **Clone Banyak Repository Sekaligus**
   ```bash
   ./scripts/git-clone-all.sh repos.txt ~/dev
   ```

## 🐳 Docker Services

Mengelola services dengan `docker-stack/control.sh`:

```bash
# Start semua services
./docker-stack/control.sh start

# Start service tertentu
./docker-stack/control.sh start mysql

# Stop service
./docker-stack/control.sh stop postgres

# Lihat logs
./docker-stack/control.sh logs redis

# Status semua services
./docker-stack/control.sh status
```

Services yang tersedia:
- MySQL (port 3306)
- PostgreSQL (port 5432)
- Redis (port 6379)
- RabbitMQ (port 5672, management UI: 15672)
- MongoDB (port 27017)
- Elasticsearch (port 9200)

## 📝 Catatan

- Semua config akan di-backup sebelum di-overwrite
- Script akan otomatis install `yay` jika belum ada
- PHP extensions untuk Laravel sudah termasuk
- Flutter setup otomatis setelah install Android Studio
- Aliases sudah lengkap untuk development workflow

## 📋 Alias Cheat Sheet

Semua alias tersedia di `~/.aliases.zsh`. Berikut adalah cheat sheet lengkap:

### 📁 File System

| Alias | Command | Description |
|-------|---------|-------------|
| `ll` | `ls -alFh` | List files dengan detail |
| `la` | `ls -A` | List semua files termasuk hidden |
| `l` | `ls -CF` | List files compact |
| `..` | `cd ..` | Naik satu level |
| `...` | `cd ../..` | Naik dua level |
| `~` | `cd ~` | Ke home directory |
| `-` | `cd -` | Ke directory sebelumnya |

### 🐳 Docker

| Alias | Command | Description |
|-------|---------|-------------|
| `d` | `docker` | Docker command |
| `dc` | `docker-compose` | Docker Compose |
| `dcu` | `docker-compose up` | Start services |
| `dcd` | `docker-compose down` | Stop services |
| `dcr` | `docker-compose restart` | Restart services |
| `dcl` | `docker-compose logs -f` | Follow logs |
| `dce` | `docker-compose exec` | Execute command |
| `dcb` | `docker-compose build` | Build images |
| `dcp` | `docker-compose ps` | List containers |
| `dps` | `docker ps` | List running containers |
| `dpsa` | `docker ps -a` | List all containers |
| `dimg` | `docker images` | List images |
| `dexec` | `docker exec -it` | Execute in container |
| `dlog` | `docker logs -f` | Follow container logs |
| `dstats` | `docker stats` | Container stats |

### 🔀 Git

| Alias | Command | Description |
|-------|---------|-------------|
| `gs` | `git status` | Status |
| `ga` | `git add` | Add files |
| `gaa` | `git add --all` | Add all files |
| `gc` | `git commit` | Commit |
| `gcm` | `git commit -m` | Commit with message |
| `gca` | `git commit --amend` | Amend commit |
| `gp` | `git push` | Push |
| `gpf` | `git push --force` | Force push |
| `gpl` | `git pull` | Pull |
| `gplr` | `git pull --rebase` | Pull with rebase |
| `gl` | `git log --oneline --graph --decorate --all` | Log dengan graph |
| `gd` | `git diff` | Diff |
| `gds` | `git diff --staged` | Diff staged |
| `gb` | `git branch` | List branches |
| `gco` | `git checkout` | Checkout |
| `gcb` | `git checkout -b` | Create & checkout branch |
| `gsw` | `git switch` | Switch branch |
| `gswc` | `git switch -c` | Create & switch |
| `gm` | `git merge` | Merge |
| `gr` | `git rebase` | Rebase |
| `gst` | `git stash` | Stash |
| `gstp` | `git stash pop` | Pop stash |
| `gf` | `git fetch` | Fetch |
| `gcl` | `git clone` | Clone |

### 📦 Package Manager (Pacman)

| Alias | Command | Description |
|-------|---------|-------------|
| `update` | `sudo pacman -Syu` | Update system |
| `install` | `sudo pacman -S` | Install package |
| `remove` | `sudo pacman -Rns` | Remove package |
| `search` | `pacman -Ss` | Search package |
| `info` | `pacman -Si` | Package info |
| `list` | `pacman -Q` | List installed |
| `orphans` | `pacman -Qtdq` | List orphans |
| `cleanup` | `sudo pacman -Rns $(pacman -Qtdq)` | Remove orphans |

### 📦 Package Manager (AUR - yay)

| Alias | Command | Description |
|-------|---------|-------------|
| `yupdate` | `yay -Syu` | Update system + AUR |
| `yinstall` | `yay -S` | Install AUR package |
| `yremove` | `yay -Rns` | Remove AUR package |
| `ysearch` | `yay -Ss` | Search AUR |

### 📦 Node.js / NPM

| Alias | Command | Description |
|-------|---------|-------------|
| `ni` | `npm install` | Install |
| `nid` | `npm install --save-dev` | Install dev dependency |
| `nig` | `npm install -g` | Install global |
| `nu` | `npm uninstall` | Uninstall |
| `nup` | `npm update` | Update |
| `nr` | `npm run` | Run script |
| `nst` | `npm start` | Start |
| `ntest` | `npm test` | Test |
| `nbuild` | `npm run build` | Build |
| `ndev` | `npm run dev` | Dev mode |

### 📦 Yarn

| Alias | Command | Description |
|-------|---------|-------------|
| `ya` | `yarn add` | Add package |
| `yad` | `yarn add --dev` | Add dev dependency |
| `yu` | `yarn remove` | Remove |
| `yup` | `yarn upgrade` | Upgrade |
| `yst` | `yarn start` | Start |
| `ytest` | `yarn test` | Test |
| `ybuild` | `yarn build` | Build |
| `ydev` | `yarn dev` | Dev mode |

### 📦 pnpm

| Alias | Command | Description |
|-------|---------|-------------|
| `pni` | `pnpm install` | Install |
| `pna` | `pnpm add` | Add package |
| `pnad` | `pnpm add -D` | Add dev dependency |
| `pnu` | `pnpm remove` | Remove |
| `pnup` | `pnpm update` | Update |
| `pnr` | `pnpm run` | Run script |
| `pnst` | `pnpm start` | Start |
| `pntest` | `pnpm test` | Test |
| `pnbuild` | `pnpm build` | Build |
| `pndev` | `pnpm dev` | Dev mode |

### 🐹 Go

| Alias | Command | Description |
|-------|---------|-------------|
| `gob` | `go build` | Build |
| `gor` | `go run` | Run |
| `got` | `go test` | Test |
| `gof` | `go fmt` | Format |
| `gov` | `go vet` | Vet |
| `gom` | `go mod` | Module command |
| `gomi` | `go mod init` | Init module |
| `gomt` | `go mod tidy` | Tidy module |
| `gomd` | `go mod download` | Download deps |
| `goi` | `go install` | Install |
| `goc` | `go clean` | Clean |
| `gog` | `go get` | Get package |
| `air` | `air` | Live reload |

### 🐘 PHP / Laravel

| Alias | Command | Description |
|-------|---------|-------------|
| `pa` | `php artisan` | Artisan command |
| `pam` | `php artisan migrate` | Migrate |
| `pamf` | `php artisan migrate:fresh` | Fresh migrate |
| `pams` | `php artisan migrate:status` | Migrate status |
| `pamr` | `php artisan migrate:rollback` | Rollback |
| `pamrs` | `php artisan migrate:refresh --seed` | Refresh & seed |
| `pas` | `php artisan serve` | Start server |
| `pat` | `php artisan tinker` | Tinker |
| `pac` | `php artisan cache:clear` | Clear cache |
| `paco` | `php artisan config:clear` | Clear config |
| `paro` | `php artisan route:clear` | Clear route |
| `pavi` | `php artisan view:clear` | Clear view |
| `pacom` | `composer` | Composer |
| `pacomi` | `composer install` | Install deps |
| `pacomu` | `composer update` | Update deps |
| `pacomr` | `composer require` | Require package |
| `pacomrd` | `composer require --dev` | Require dev |
| `pacomd` | `composer dump-autoload` | Dump autoload |

### 📱 Flutter

| Alias | Command | Description |
|-------|---------|-------------|
| `fl` | `flutter` | Flutter command |
| `flr` | `flutter run` | Run app |
| `flrd` | `flutter run -d` | Run on device |
| `flb` | `flutter build` | Build |
| `flba` | `flutter build apk` | Build APK |
| `flbi` | `flutter build ios` | Build iOS |
| `flt` | `flutter test` | Test |
| `flc` | `flutter clean` | Clean |
| `flg` | `flutter get` | Get packages |
| `flp` | `flutter pub` | Pub command |
| `flpi` | `flutter pub get` | Get packages |
| `flpu` | `flutter pub upgrade` | Upgrade packages |
| `fld` | `flutter doctor` | Doctor check |
| `fldv` | `flutter doctor -v` | Doctor verbose |
| `fla` | `flutter analyze` | Analyze |
| `flfmt` | `flutter format .` | Format code |

### 🗄️ Database

| Alias | Command | Description |
|-------|---------|-------------|
| `mysqlc` | `mysql -u dev_user -pdev_password dev_db` | MySQL client |
| `psqlc` | `psql -U dev_user -d dev_db` | PostgreSQL client |
| `redis-cli` | `redis-cli` | Redis client |

### 🌐 Network

| Alias | Command | Description |
|-------|---------|-------------|
| `ping` | `ping -c 5` | Ping 5 times |
| `ports` | `netstat -tulanp` | List ports |
| `ip` | `ip -c` | IP command (color) |
| `ipa` | `ip addr show` | Show IP addresses |
| `ipr` | `ip route show` | Show routes |

### 🛠️ Development Tools

| Alias | Command | Description |
|-------|---------|-------------|
| `code` | `cursor` | Open Cursor editor |
| `vim` | `nvim` | Neovim |
| `vi` | `nvim` | Neovim |
| `top` | `htop` | Htop |
| `df` | `df -h` | Disk free (human) |
| `du` | `du -h` | Disk usage (human) |
| `free` | `free -h` | Memory (human) |

### 📂 Quick Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `dev` | `cd ~/dev` | Go to dev folder |
| `projects` | `cd ~/projects` | Go to projects |
| `downloads` | `cd ~/Downloads` | Go to downloads |
| `documents` | `cd ~/Documents` | Go to documents |

### 🔧 Process Management

| Alias | Command | Description |
|-------|---------|-------------|
| `psg` | `ps aux \| grep` | Search process |
| `killp` | `kill -9` | Kill process |
| `psmem` | `ps aux \| sort -nr -k 4` | Sort by memory |
| `pscpu` | `ps aux \| sort -nr -k 3` | Sort by CPU |

### 💡 Tips

- Tambahkan alias custom di `~/.aliases.zsh` bagian bawah
- Reload shell: `source ~/.zshrc` atau restart terminal
- Lihat semua alias: `alias` atau `cat ~/.aliases.zsh`

## 🎯 Next Steps

1. Restart terminal atau `source ~/.zshrc`
2. Edit `~/.gitconfig` dengan info kamu
3. Tambahkan repos ke `repos.txt` dan clone semua
4. Start docker services sesuai kebutuhan
5. Happy coding! 🚀

