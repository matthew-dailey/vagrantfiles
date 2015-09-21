#!/bin/bash

# install extra GTK modules to prevent warnings
sudo apt-get update -y
sudo apt-get install -y \
    packagekit-gtk3-module \
    libcanberra-gtk-module \
    xserver-xorg \
    xserver-xorg-video-intel

UNITY_FILE=unity-editor-5.1.0f3+2015082501_amd64.deb
UNITY_URL=http://download.unity3d.com/download_unity/${UNITY_FILE}

if ! [ -e /vagrant/$UNITY_FILE ] ; then
    echo "Downloading $UNITY_FILE"
    wget $UNITY_URL
    mv $UNITY_FILE /vagrant/$UNITY_FILE
fi

sudo dpkg -i /vagrant/$UNITY_FILE
if ! sudo apt-get install -f -y ; then
    echo "Failed to install unity .deb file"
    exit 1
fi
sudo chown -R vagrant:vagrant /opt
sudo chown root:root /opt/Unity/Editor/chrome-sandbox
sudo chmod 4755 /opt/Unity/Editor/chrome-sandbox

# Add 'Unity' and 'monodevelop' to PATH
echo '
mono_home=/opt/Unity/Editor/Data/Mono
monodev_home=/opt/Unity/MonoDevelop
unity_home=/opt/Unity/Editor
export PATH=$PATH:${mono_home}/bin:${monodev_home}/bin

# Unity likes to be called with full path
alias Unity="${unity_home}/Unity"
' >> ~vagrant/.bashrc
sudo chown vagrant:vagrant ~vagrant/.bashrc

mkdir -p ~vagrant/.config/ ~vagrant/.local/
sudo chown vagrant:vagrant ~vagrant/.config ~vagrant/.local
