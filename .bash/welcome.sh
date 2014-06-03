#!/usr/bin/env bash
# see: http://parkersamp.com/2010/10/howto-creating-a-dynamic-motd-in-linux/
 
PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`

echo "\033[1;32m 
  _______ __               _______        __           __                __   
 |   _   |__|.--------.   |   _   |.----.|  |--.--.--.|  |--.-----.----.|  |_ 
 |___|   |  ||        |   |   1___||  __||     |  |  ||  _  |  -__|   _||   _|
 |.  |   |__||__|__|__|   |____   ||____||__|__|_____||_____|_____|__|  |____|
 |:  1   |                |:  1   |                                           
 |::.. . |                |::.. . |                                           
 \`-------'                \`-------'                                           
                                                                              
\033[1;33m+++++++++++++++++: \033[0;37mSystem Data\033[1;33m :+++++++++++++++++++
+  \033[0;37mHostname \033[1;33m= \033[1;32m`hostname`
\033[1;33m+    \033[0;37mKernel \033[1;33m= \033[1;32m`uname -rpms`
\033[1;33m+    \033[0;37mUptime \033[1;33m= \033[1;32m`uptime | sed 's/.*up ([^,]*), .*/1/'`
\033[1;33m++++++++++++++++++: \033[0;37mUser Data\033[1;33m :++++++++++++++++++++
+  \033[0;37mUsername \033[1;33m= \033[1;32m`whoami`
\033[1;33m+  \033[0;37mSessions \033[1;33m= \033[1;32m`who | grep $USER | wc -l` of $ENDSESSION MAX
\033[1;33m+ \033[0;37mProcesses \033[1;33m= \033[1;32m$PROCCOUNT of `ulimit -u 2>/dev/null` MAX
\033[1;33m+++++++++++++++++++++++++++++++++++++++++++++++++++
"
cat /etc/motd
