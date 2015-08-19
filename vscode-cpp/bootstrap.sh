#!/bin/bash

devtools='
vim
git
unzip
'
x11_stuff='
xorg-x11-xauth
libXtst
libXrender
'

vscode_gui_libs='
gtk2
GConf2
xorg-x11-fonts-Type1
Packagekit-gtk3-module
dejavu-sans-mono-fonts
dejavu-sans-fonts
'

sudo yum install -y \
    $x11_stuff \
    $vscode_gui_libs \
    $devtools

VSCODE_FILE=VSCode-linux-x64.zip
if ! [ -e /vagrant/$VSCODE_FILE ] ; then
    echo "Downloading $VSCODE_FILE"
    wget http://download.microsoft.com/download/0/D/5/0D57186C-834B-463A-AECB-BC55A8E466AE/$VSCODE_FILE
    mv $VSCODE_FILE /vagrant/$VSCODE_FILE
fi
unzip -d ~vagrant/VSCode /vagrant/$VSCODE_FILE
chown -R vagrant:vagrant ~vagrant/VSCode

echo '
vscode_home=$HOME/VSCode
export PATH=$PATH:$vscode_home/
' >> ~vagrant/.bash_profile
