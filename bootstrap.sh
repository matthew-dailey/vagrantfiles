#!/bin/sh

sudo yum update
sudo yum install -y vim git

# pull down Java and install it
JDK_FILE=jdk-8u51-linux-x64.rpm
JDK_URL=http://download.oracle.com/otn-pub/java/jdk/8u51-b16/${JDK_FILE}

if ! [ -e /vagrant/$JDK_FILE ] ; then
    echo "Downloading $JDK_FILE"
    wget --no-check-certificate --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         $JDK_URL
    mv $JDK_FILE /vagrant/$JDK_FILE
fi
sudo rpm -ivh /vagrant/$JDK_FILE

# install intellij community edition and put in path
IDEA_FILE=ideaIC-14.1.4.tar.gz

if ! [ -e /vagrant/$IDEA_FILE ] ; then
    echo "Downloading $IDEA_FILE"
    wget http://download.jetbrains.com/idea/$IDEA_FILE
    mv $IDEA_FILE /vagrant/$IDEA_FILE
fi
tar xzvf /vagrant/$IDEA_FILE
ln -sf idea-IC-* idea

# setup vagrant users's PATH
echo '
export PATH=$PATH:$HOME/idea/bin
' >> ~vagrant/.bash_profile
