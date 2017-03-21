#!/bin/bash
# exxtract the firmware and keep the extrated file only
if [ $# -lt 2 ] ; then
	#$extrfile | binwalk -Me $1
	#echo _$1.extracted
	extrfile=_${1##*/}.extracted
	if [ -d $extrfile ] ; then
		echo moving $extrfile ...
		rm -r $extrfile
	fi
	if [ ! -f binwalk.log ] ; then
		touch binwalk.log
	fi
	rm binwalk.log
	binwalk --quiet -f binwalk.log  -Me $1
fi
# search intensive files
#targetfile=(passwd shadow rcs inittab init.d rc.d network resolv.conf dhclient.conf xinetd.d modules.conf httpd.conf vsftpd.conf smb.conf sshd_config ssh_config dhcpd.conf named.conf)
targetfile=(passwd shadow)
savedpath=${1##*/}_targetfiles
if [ ! -d $savedpath  ] ; then 
	mkdir $savedpath
fi
length=${#targetfile[*]}
for((i=0;i<$length;++i));
do
	#echo searching ${targetfile[i]}
	FILE=`find $extrfile -name ${targetfile[i]}` 
	cp $FILE $savedpath/
	echo $FILE
		
done
