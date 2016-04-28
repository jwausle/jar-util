#!/bin/sh
JAR=""
JAR_PATH=""

jcat () 
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
   
   echo "${_JAR}!${_PATH}"
   cat ${DIR}/${_PATH} 2>&1 | sed 's,'${DIR}','${_JAR}',g'
   echo ""
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
   echo "JAR=${JAR}, JAR_PATH=${JAR_PATH}"
   jcat ${JAR} ${JAR_PATH} 
done





