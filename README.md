# jar-util
Some shell utils to find, grep and cat jar internals 

`jfind.sh JAR` # show files inside jar

requiere: *sh, mktemp, jar, sed*

`jcat.sh JAR!PATH*` # cat the content of file inside JAR

requiere: *sh, mktemp, jar, sed*

`jgrep.sh EXPR JAR[!PATH]*` # grep for EXPR in content of files inside JAR

requiere: *sh, mktemp, jar, sed, grep*

`jdecompile JAR!CLASS` # decompile CLASS to SRC.java, 

requiere: *sh, mktemp, jar, sed, java*

use: https://bitbucket.org/mstrobel/procyon/wiki/Java%20Decompiler as decompiler

## Samples: 

`jfind JAR | grep "\.class" | xargs jdecompile` 
to decompile all classes from as JAR file

`jfind JAR | grep "\.properties" | xargs jcat`
to cat all properties files inside a JAR file
