#!/bin/sh

sudo yum update
sudo yum install -y gcc-c++ git

# pull down Java and install it
JDK_FILE=jdk-8u51-linux-x64.rpm
JDK_URL=http://download.oracle.com/otn-pub/java/jdk/8u51-b16/${JDK_FILE}

if [ -e /vagrant/$JDK_FILE ] ; then
    echo "Copying $JDK_FILE"
    cp /vagrant/$JDK_FILE .
else
    echo "Downloading $JDK_FILE"
    wget --no-check-certificate --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         $JDK_URL
    cp $JDK_FILE /vagrant/$JDK_FILE
fi
sudo rpm -ivh $JDK_FILE

# install intellij community edition and put in path
IDEA_FILE=ideaIC-14.1.4.tar.gz

if [ -e /vagrant/$IDEA_FILE ] ; then
    echo "Extracting $IDEA_FILE"
    tar xzvf /vagrant/$IDEA_FILE
else
    echo "Downloading $IDEA_FILE"
    wget http://download.jetbrains.com/idea/$IDEA_FILE
    cp $IDEA_FILE /vagrant/$IDEA_FILE
    tar xzvf $IDEA_FILE
fi
ln -sf idea-IC-* idea

echo '
export PATH=$PATH:$HOME/idea/bin
' >> $HOME/.bash_profile

# cleanup
#rm -f $IDEA_FILE $JDK_FILE
