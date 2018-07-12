# dotfiles
My dotfiles and configuration files, and an easy boostrapping framework to install dependencies, applications, preferences on a system.

With help from @holman's dotfiles, with inspiration by @mathiasbynens and others.

## layout
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: List of apps/dependencies for [Homebrew Cask](http://caskroom.io) to install. Can and should be modified as needed before setup.
- **\[topic\]/\*.zsh**: Any files throughout the projectending in `.zsh` get loaded into the shell
  environment.
- **\[topic\]/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **\[topic\]/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete. Optional.
- **\[topic\]/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`. To specify a **custom symlink location** for a file called `myfile.symlink`, simply create a script file in the same directory called `myfile.loc`, which prints (e.g. `echo`) the complete path to link to. This can be OS-specific.


## install
```
git clone https://github.com/jacobkahn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

Bootstrapping symlinks files in `.dotfiles` to the home directory. Modifications should happen within `~/.dotfiles`.

`zsh/zshrc.symlink` is responsible for paths, which may need machine-specific changes.

`dot` installs dependencies, sets OS defaults, etc. Can be run regularly to refresh and update.

