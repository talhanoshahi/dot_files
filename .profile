# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#EDITOR='/usr/bin/emacsclient -c --alternate-editor="/usr/bin/emacs"'
EDITOR='nvim'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

$PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
$PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin
$PATH | grep -Eq "(^|:)/${HOME}/.local/bin(:|)" || PATH=$PATH:${HOME}/.local/bin
$PATH | grep -Eq "(^|:)/${HOME}/.local/scripts(:|)" || PATH=$PATH:${HOME}/.local/scripts
$PATH | grep -Eq "(^|:)/${HOME}/.local/scripts/statusbar(:|)" || PATH=$PATH:${HOME}/.local/scripts/statusbar
$PATH | grep -Eq "(^|:)/${HOME}/.local/scripts/bookmarks(:|)" || PATH=$PATH:${HOME}/.local/scripts/bookmarks
[ -d $HOME/.local/share/gem/ruby/3.0.0 ] && $PATH | grep -Eq "(^|:)/${HOME}/.local/share/gem/ruby/3.0.0(:|)" || PATH=$PATH:${HOME}/.local/share/gem/ruby/3.0.0

export PATH
xmodmap ~/.config/xmodmap/xmodmaprc

# startx

if [ -e /home/system_failure/.nix-profile/etc/profile.d/nix.sh ]; then . /home/system_failure/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
