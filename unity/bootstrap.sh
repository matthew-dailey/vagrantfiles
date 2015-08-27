#!/bin/bash

# install extra GTK modules to prevent warnings
sudo apt-get update -y
sudo apt-get install -y \
    packagekit-gtk3-module \
    libcanberra-gtk-module

UNITY_FILE=unity-editor-5.1.0f3+2015082501_amd64.deb
UNITY_URL=http://download.unity3d.com/download_unity/${UNITY_FILE}

if ! [ -e /vagrant/$UNITY_FILE ] ; then
    echo "Downloading $UNITY_FILE"
    wget $UNITY_URL
    mv $UNITY_FILE /vagrant/$UNITY_FILE
fi
sudo dpkg -i /vagrant/$UNITY_FILE
sudo apt-get install -f -y

# Add 'Unity' and 'monodevelop' to PATH
echo '
mono_home=/opt/Unity/MonoDevelop
unity_home=/opt/Unity/Editor
export PATH=$PATH:${mono_home}/bin:${unity_home}'
