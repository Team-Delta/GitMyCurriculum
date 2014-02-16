#!/bin/bash

#Script for installing project setup on Ubuntu
#curl used for getting rvm and ruby install
if ! dpkg -l | grep -qw curl; then
    echo "#####################################################"
    echo "# Package for curl was not found, Installing now... #"
    echo "#####################################################"
    sudo apt-get install curl
else
    echo "###################################################"
    echo "# Package for curl found....                      #"
    echo "###################################################"
fi

# mysql-server used for application dbms
if ! dpkg -l | grep -qw mysql-server; then
    echo "###################################################################"
    echo "# Package for mysql-server was not found, Installing now...       #"
    echo "###################################################################\n"
    echo "###################################################################"
    echo "#                                                                 #"
    echo "#                                                                 #"
    echo "#                                                                 #"
    echo "# create mysql user with username: root and password: root        #"
    echo "#                                                                 #"
    echo "#                                                                 #"
    echo "#                                                                 #"
    echo "#                                                                 #"
    echo "###################################################################"
    sudo apt-get install mysql-server
else
    echo "##################################################################"
    echo "# Package for mysql-server found....                             #"
    echo "##################################################################"
fi

# openjdk required for running sunspot solr
if ! dpkg -l | grep -qw openjdk-7-jre; then
    echo "##############################################################"
    echo "# Package for openjdk-7-jre was not found, Installing now... #"
    echo "##############################################################"
    sudo apt-get install openjdk-7-jre
else
    echo "############################################################"
    echo "# Package for openjdk-7-jre found....                      #"
    echo "############################################################"
fi

# nodejs required for javascript runtime with ruby on rails
if ! dpkg -l | grep -qw nodejs; then
    echo "#######################################################"
    echo "# Package for nodejs was not found, Installing now... #"
    echo "#######################################################"
    sudo apt-get install nodejs
else
    echo "#####################################################"
    echo "# Package for nodejs found....                      #"
    echo "#####################################################"
fi

#install rvm with ruby and rails
if test "$HOME/.rvm/scripts/rvm"; then
  # First try to load from a user install
  echo "###############################################################"
  echo "# found user install in $HOME/.rvm/scripts/rvm      #"
  echo "###############################################################"
elif test "/usr/local/rvm/scripts/rvm"; then
  # Then try to load from a root install
  echo "#####################################################"
  echo "# found user install in  /usr/local/rvm/scripts/rvm #"
  echo "#####################################################"
else
  echo "#####################################################"
  echo "# RVM install was not found, Installing now...      #"
  echo "#####################################################"
  sudo \curl -sSL get.rvm.io | bash -s stable --rails
  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
  source $HOME/.bashrc
fi


