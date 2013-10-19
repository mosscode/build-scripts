#!/bin/bash

rm pom.xml

MODULES=`find * -maxdepth 1 -name pom.xml -exec dirname {} \;`

echo "<project>
<modelVersion>4.0.0</modelVersion>
<groupId>foo</groupId>
<artifactId>bar</artifactId>
<version>0.0.1-SNAPSHOT</version>
<packaging>pom</packaging>
<modules>" > pom.xml

for M in $MODULES;
do 
    echo "<module>$M</module>" >> pom.xml; 
done;

echo "</modules></project>" >> pom.xml
