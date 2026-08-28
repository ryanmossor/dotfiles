# dotfiles

## Starting from fresh system

### Omarchy

```bash
omarchy update

git clone https://github.com/ryanmossor/dotfiles.git ~/dotfiles
cd ~/dotfiles

./install.sh --omarchy | tee output.txt
./stow.sh --omarchy
```

### Ubuntu/Mint

```bash
sudo apt-get update
sudo apt-get install git -y

git clone https://github.com/ryanmossor/dotfiles.git ~/dotfiles
cd ~/dotfiles

./install.sh --ubuntu | tee output.txt
./stow.sh --ubuntu
```

## Install examples

Initial installation/setup script. Can also be run to handle software updates.

**Install base packages and dev environment:**
```bash
./install.sh | tee output.txt
```

**Base install plus Omarchy desktop setup (WM, fonts, desktop apps, etc.):**
```bash
./install.sh --omarchy | tee output.txt
```

**Dry run (print what *would* be executed, but don't execute it):**
```bash
./install.sh --dry
```

**Filters -- install *only* `lazygit` and `neovim`:**
```bash
./install.sh lazygit neovim
```

## Apply configurations

**Apply base configs:**
```bash
./stow.sh
```

**Options:**
```
-h, --help
    Show help

-d, -r, --delete, --remove
    Remove all config files

-m, --macos
    Apply MacOS-specific configs

-o, --omarchy
    Apply Omarchy-specific configs

-u, --ubuntu
    Apply Ubuntu-specific configs

-w, --windows
    Apply Windows-specific configs (copies files; no symlinks)
```
