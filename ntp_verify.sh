#!/bin/bash

ntpconf=/etc/ntp.conf
st_ntpconf=`dirname $0`/st_ntp.conf
dif_ntpconf=`diff -q $st_ntpconf $ntpconf | wc -l`

#check status of service NTP
status_ntp=`ps ax | grep ntpd | grep -v grep | wc -l`
if [ $status_ntp -eq "0" ] ; then
	/etc/init.d/ntp start
fi

#check change in ntp.conf
if [ $dif_ntpconf -eq "1" ] ; then
	echo "NOTICE: $ntpconf was changed. Calculated diff:"
	diff -u $st_ntpconf $ntpconf
	cp $st_ntpconf $ntpconf
	/etc/init.d/ntp restart
fi

