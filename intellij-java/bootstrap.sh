#!/bin/sh

sudo yum update

# Any files that we download manually, we'll move into /vagrant
# so that we won't have to download them again if we rebuild
# this image.

CHEF_FILE=chefdk-0.6.2-1.el7.x86_64.rpm
if ! [ -e /vagrant/$CHEF_FILE ] ; then
    echo "Downloading $CHEF_FILE"
    wget https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/$CHEF_FILE
    mv $CHEF_FILE /vagrant/$CHEF_FILE
fi
rpm -ivh /vagrant/$CHEF_FILE

# TODO: should put this as a 'provision' in the Vagrantfile
chef-apply /vagrant/packages.rb

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
chown -R vagrant:vagrant idea-IC-*
ln -sf idea-IC-* idea

# install Maven
MAVEN_FILE=apache-maven-3.3.3-bin.tar.gz
if ! [ -e /vagrant/$MAVEN_FILE ] ; then
    echo "Downloading $MAVEN_FILE"
    wget http://mirror.reverse.net/pub/apache/maven/maven-3/3.3.3/binaries/$MAVEN_FILE
    mv $MAVEN_FILE /vagrant/$MAVEN_FILE
fi
tar xzvf /vagrant/$MAVEN_FILE
chown -R vagrant:vagrant apache-maven-*
ln -sf apache-maven-* apache-maven

# I won't manually install gradle because usually projects have the
# gradle wrapper to install gradle for their project

# setup vagrant users's PATH
echo '
maven_home=$HOME/apache-maven
export PATH=$PATH:$maven_home/bin:$HOME/idea/bin
' >> ~vagrant/.bash_profile

# if you have IntelliJ config/cache in /vagrant, copy them into place
IDEA_CONFIG_DIR=.IdeaIC14
if [ -e /vagrant/$IDEA_CONFIG_DIR ] ; then
    cp /vagrant/$IDEA_CONFIG_DIR ~vagrant/
    chown -R vagrant:vagrant ~vagrant/$IDEA_CONFIG_DIR
fi
