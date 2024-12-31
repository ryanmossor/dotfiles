# dotfiles

## Starting from fresh system

```bash
sudo apt-get update
sudo apt-get install git -y

git clone https://github.com/ryanmossor/dotfiles.git ~/dotfiles
cd ~/dotfiles

./install.sh --personal | tee output.txt
./stow.sh --personal
```

## Install examples

Initial installation/setup script. Can also be run to handle software updates.

**Install base packages and dev environment:**
```bash
./install.sh | tee output.txt
```

**Base install plus Linux desktop setup (WM, fonts, desktop apps, etc.):**
```bash
./install.sh --personal | tee output.txt
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

-p, --personal
    Apply personal configs

-w, --windows
    Apply Windows configs (copies files; no symlinks)
```
