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

## 🎯 Next Steps

1. Restart terminal atau `source ~/.zshrc`
2. Edit `~/.gitconfig` dengan info kamu
3. Tambahkan repos ke `repos.txt` dan clone semua
4. Start docker services sesuai kebutuhan
5. Happy coding! 🚀

