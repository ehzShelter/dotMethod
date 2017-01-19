#!/bin/bash

DISTRO=$(lsb_release -c -s)

check_alt() {
        echo
        echo "you are using $HOSTTYPE LINUX $DISTRO"
        echo "## Using ${1} ${2} ."
}

check_alt "$(lsb_release -r)" "$(lsb_release -d)"

rm -rf node-v6.0.0-linux-x64.tar*
echo "Removing package manager based Installation"

sudo apt-get purge -y node

echo "removing nvm based Installation"
rm -rf ~/.nvm

echo "Installing dependencies readline-editor"
sudo apt-get install -y rlwrap

echo "Download node source code"
wget https://nodejs.org/dist/v6.0.0/node-v6.0.0-linux-x64.tar.xz

echo "extracting file"
tar xvf node-v6.0.0-linux-x64.tar.xz


if [ -d ~/.myNode ]; then
  rsync -a ~/.myNode ~/prevNode
else
  mv "node-v6.0.0-linux-x64" ~/.myNode
fi

# node Development Kit
grep -q -F 'export NODE_HOME=~/.myNode' ~/.bash_profile || echo 'export NODE_HOME=~/.myNode' >> ~/.bash_profile
grep -q -F 'export PATH=$NODE_HOME/bin:$PATH' ~/.bash_profile || echo 'export PATH=$NODE_HOME/bin:$PATH' >> ~/.bash_profile
grep -q -F 'unset MANPATH' ~/.bash_profile || echo 'unset MANPATH' >> ~/.bash_profile
grep -q -F 'export MANPATH="$NODE_HOME/share/man:$(manpath)"' ~/.bash_profile || echo 'export MANPATH="$NODE_HOME/share/man:$(manpath)"' >> ~/.bash_profile

source ~/.bash_profile

if [ $? == 0 ]; then
  echo "node version"
  node -v
  echo "npm version"
  npm -v
  echo "Successfully Installed"
else
  echo "something went wrong"
fi

# for sanity reloading once again
source ~/.bash_profile

