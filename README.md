# Dotfiles

This is my repository of dot-files. Mainly my configuration for `vim, emacs and i3`. I use vim mostly, but I do want to change over to `emacs` because of org-mode and other advantages. But until then, the vim configuration should work for any system that has `nodejs` installed.

# Full Setup

The above also contains an installation script that can install all my configuration in one shot. The script was developed mainly for the version 20.04 of Ubuntu Distribution but however should also work on latest versions of it.

To install the full configuration, run

**W-GET**

```
bash -c "$(wget https://raw.githubusercontent.com/blank-manash/dotfiles/master/install.sh -O -)"
```
**Curl**

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/blank-manash/dotfiles/master/install.sh)"
```

----

If you want a minimal `.vimrc` that works on any system, click [!here](https://github.com/blank-manash/.vimrc-file).
