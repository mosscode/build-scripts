#!/bin/bash

SOURCE_REPO=~/.m2/repository
DEST_REPO=mvn-repository
function copyLocalMvnStuff {
  FRAG="$1"
  FRAG=`echo $FRAG | sed 's|[.:]|/|g'`
  echo "Copying $FRAG"
  FRAG_DEST="$DEST_REPO/$FRAG"
  rm -rf $FRAG_DEST
  mkdir -p `dirname $FRAG_DEST`
  cp -Rpv "$SOURCE_REPO/$FRAG" "$FRAG_DEST"
}

THINGS="javax.activation:activation
javax/jms
javax/jws/jsr181
com/sun/jdmk/jmxtools
com/sun/jmx/jmxri
com/sleepycat/je
javax/transaction/jta
org/dstovall
org/apache/maven
org/xbill/dns
berkeleydb:je"

for THING in $THINGS;
do 
    copyLocalMvnStuff $THING
done

