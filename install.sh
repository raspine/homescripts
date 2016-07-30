#!/bin/bash
# installs my personal scripts on a Arch host

is_package_installed() { #{{{
  #check if a package is already installed
  for PKG in $1; do
    pacman -Q $PKG &> /dev/null && return 0;
  done
  return 1
} #}}}

clever_ln_s() {
  if [ -f $2 ] && [ ! -L $2 ]; then
    # regular file, make backup
    mv $2 $2_bak
  elif [ -L $2 ]; then
    # already symlink
    return
  fi
  ln -s $1 $2
}

# needed packages
if ! is_package_installed "yaourt" ; then
  echo "plz install yaourt"
  return 1
fi
if ! is_package_installed "sshrc" ; then
  yaourt -S "sshrc"
fi

# home dir
clever_ln_s ~/homescripts/.bashrc ~/.bashrc
clever_ln_s ~/homescripts/.xinitrc ~/.xinitrc
clever_ln_s ~/homescripts/.Xmodmap ~/.Xmodmap
clever_ln_s ~/homescripts/.Xresources ~/.Xresources
clever_ln_s ~/homescripts/.xprofile ~/.xprofile
clever_ln_s ~/homescripts/.sshrc ~/.sshrc

# vim
mkdir -p ~/.vim/ftplugin
clever_ln_s ~/homescripts/.vimrc ~/.vim/vimrc
clever_ln_s ~/homescripts/ftplugin/java.vim ~/.vim/ftplugin/java.vim
clever_ln_s ~/homescripts/ftplugin/lua.vim ~/.vim/ftplugin/lua.vim
clever_ln_s ~/homescripts/ftplugin/cpp.vim ~/.vim/ftplugin/cpp.vim
clever_ln_s ~/homescripts/ftplugin/sh.vim ~/.vim/ftplugin/sh.vim
clever_ln_s ~/homescripts/ftplugin/vim.vim ~/.vim/ftplugin/vim.vim

# vifm
mkdir -p ~/vifm/colors
clever_ln_s ~/homescripts/vifm/vifmrc ~/.vifm/vifmrc
clever_ln_s ~/homescripts/vifm/colors/astrall.vifm ~/.vifm/colors/astrall.vifm

