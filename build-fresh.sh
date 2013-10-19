#!/bin/bash
DIR=$1
GITHUB_CREDENTIALS=$2
SCRIPTS=`pwd`
set -e

if [ -z "$DIR" ]
then
   echo "You must specify a directory"
   exit -4
fi

if [ -d $DIR ]
then
   CONTENTS=`ls $DIR`
   if [ "$(ls -A $DIR)" ]; then 
       echo "DIRECTORY MUST BE EMPTY: $DIR"
       exit -3
   fi
fi

mkdir -p $DIR
DIR=`realpath $DIR`

set -x

echo '<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">' > $DIR/settings.xml
echo "	<localRepository>$DIR/mvn-repository</localRepository>
	
</settings>" >> $DIR/settings.xml

cd $DIR
$SCRIPTS/gitall.sh $GITHUB_CREDENTIALS
$SCRIPTS/makePom.sh  
$SCRIPTS/fetch-local-dependencies.sh
$SCRIPTS/build.sh
