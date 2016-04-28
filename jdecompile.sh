#!/bin/sh

JAR=""
JAR_PATH=""

javadclass () 
{
   _JAR=$1
   _PATH=$2
   if [ "${1}" == "" ] ; then
      echo "Frist parameter must be a JAR[!PATH] file."
      return -1
   fi
   
   if [ ! -f ${_JAR} ] ; then
      echo "'${_JAR}': No such jar file."
      exit -2 
   fi

   DIR=$(mktemp -d)
   ( cd ${DIR} && jar -xf ${_JAR} )

   java -jar procyon-decompiler-0.5.30.jar ${DIR}/${_PATH}
   
   rm -rf ${DIR}
}

javadjar () {
   _JAR=$1

   if [ ! -f ${_JAR} ] ; then
      echo "'${_JAR}': No such jar file."
      exit -2 
   fi

   java -jar procyon-decompiler-0.5.30.jar --jar-file ${_JAR} 
} 

for i in $* ; do
   BEFOR=`echo "$i" | sed 's,!.*,,g'`
   AFTER=`echo "$i" | sed 's,.*!,,g'`
   JAR_PATH=""
   if [ "${JAR}" == "" ] && [ "${BEFOR}" == "${AFTER}" ] ; then 
      JAR=${BEFOR}
      javadjar ${JAR}
      continue
   elif [ "${BEFOR}" == "${AFTER}" ] ; then
      JAR_PATH=${BEFOR}     
   else 
      JAR=${BEFOR}
      JAR_PATH=${AFTER}
   fi
   echo "JAR=${JAR}, JAR_PATH=${JAR_PATH}"
   javadclass ${JAR} ${JAR_PATH} 
done





