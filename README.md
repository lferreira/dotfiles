## Luiz's dotfiles

Warning: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Git-free install

```
cd; curl -L https://github.com/lferreira/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,install.sh,.osx,LICENSE-MIT.txt}
```

### How to install

```
make env/install
```

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
