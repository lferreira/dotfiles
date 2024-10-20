[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

## Screenshot

![howitlookslike](https://github.com/lferreira/dotfiles/assets/966489/a3d631d6-8d0c-424a-969c-97c4f26190bc)

## Requirements

- [Alacritty](https://github.com/jwilm/alacritty)
- [Neovim 0.8+](https://github.com/neovim/neovim/releases/tag/v0.8.1)
- [packer.nvim](https://github.com/wbthomason/packer.nvim)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Luiz's dotfiles

Warning: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Git-free install

```
mkdir -p ~/.dotfiles && cd ~/.dotfiles && curl -L https://github.com/lferreira/dotfiles/tarball/master | tar -xzv --strip-components 1
```

### Installing the environment

```
make osx/install
```

### Installing password-manager

```
make osx/install/password-manager
```

this is not gonna work for you =P but if you want to have
someting similar I have two private repos:

pwd-store: gpg encrypted structured files related to my credentials
pwd-key: pgp private/public keys

So basically I store them on my github and I have a shortcut on my terminal to xcopy them when
it's necessary.

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Luiz Ferreira"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="luizhgferreira@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/lferreira/dotfiles/fork) instead, though.

## Feedback

Suggestions/improvements
[welcome](https://github.com/lferreira/dotfiles/issues)!
