#!/bin/bash
# ----------------------------------------------------------------------------
#
# Package       : xz-java
# Version       : v1.10
# Source repo   : https://github.com/tukaani-project/xz-java
# Tested on     : UBI 9.3
# Language      : Java
# Travis-Check  : True
# Script License: Apache License, Version 2 or later
# Maintainer    : Siddesh Sangodkar <siddesh.sangodkar1@ibm.com>
#
# Disclaimer: This script has been tested in root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

set -e
# Install tools and dependent packages
yum install -y git wget unzip nano vim make dos2unix

# setup java environment
# update the path env. variable 
yum install -y git wget gcc gcc-c++ java-11-openjdk java-11-openjdk-devel

export JAVA_HOME=/usr/lib/jvm/$(ls /usr/lib/jvm/ | grep -P '^(?=.*java-11)(?=.*ppc64le)')
export PATH=$JAVA_HOME/bin:$PATH


# variables
PACKAGE_NAME=xz-java
PACKAGE_VERSION=${1:-v1.10}
PACKAGE_URL=https://github.com/tukaani-project/xz-java

#Install ant
wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.15-bin.tar.gz
tar -xzf apache-ant-1.10.15-bin.tar.gz
export PATH=$(pwd)/apache-ant-1.10.15/bin/:$PATH


# clone, build and test specified version
git clone $PACKAGE_URL
cd $PACKAGE_NAME
git checkout $PACKAGE_VERSION 
 

if ! ant ; then
    echo "------------------$PACKAGE_NAME:install_fails-------------------------------------"
    echo "$PACKAGE_URL $PACKAGE_NAME"
    echo "$PACKAGE_NAME  |  $PACKAGE_URL | $PACKAGE_VERSION | $OS_NAME | GitHub | Fail |  Install_Fails"
    exit 1
fi			
# No tests found

echo "$PACKAGE_NAME  |  $PACKAGE_URL | $PACKAGE_VERSION | $OS_NAME | GitHub | Success |  Install_Success"
exit 0
