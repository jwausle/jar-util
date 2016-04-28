#!/bin/sh

if [ "${1}" == "" ] ; then
   echo "usage jgrep: 'EXPR' expected."
   exit -1
fi

EXPR=$1
shift

JAR=""
JAR_PATH=""

jgrep () 
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

   if [ -d "${DIR}/${_PATH}" ] ; then
      return 0
   fi   
   
   RESULT=`grep ${EXPR} ${DIR}/${_PATH} 2>&1 | sed 's,'${DIR}','${_JAR}',g'`
   if [ "${RESULT}" != "" ] ; then
      echo "${_JAR}!/${_PATH}"
      echo "${RESULT}"
   fi

   rm -rf ${DIR}
}

for i in $* ; do
   BEFOR=`echo "$i" | sed 's,!.*,,g'`
   AFTER=`echo "$i" | sed 's,.*!,,g'`
   JAR_PATH=""
   if [ "${JAR}" == "" ] && [ "${BEFOR}" == "${AFTER}" ] ; then 
      JAR=${BEFOR}
      continue
   elif [ "${BEFOR}" == "${AFTER}" ] ; then
      JAR_PATH=${BEFOR}     
   else 
      JAR=${BEFOR}
      JAR_PATH=${AFTER}
   fi

   jgrep ${JAR} ${JAR_PATH} 
done





