chmod +x MyJavaTools.sh
cp MyJavaTools.sh /data/data/com.termux/files/usr/bin
pkg update
pkg install ecj && pkg install dx && pkg install zip && pkg install unzip
