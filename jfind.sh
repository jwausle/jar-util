#!/bin/sh

if [ "${1}" == "" ] ; then 
   echo "Argument JAR file expected." 
   exit -1
fi

for JAR in $* ; do
   if [ ! -f ${JAR} ] ; then
      echo "JAR=$'{JAR}' file not exist."
      continue 
   fi 

   DIR=`mktemp -d`
   ( cd ${DIR} && jar -xf ${JAR} )
   find ${DIR} | sed 's,'${DIR}','${JAR}'!,g' 

   rm -rf ${DIR}
done
