#!/bin/bash
apt-get install ntp -y

PWD=`dirname $0`

FILE="/etc/ntp.conf"
def_ntp='^pool '
new_ntp="pool ua.pool.ntp.org iburst"

sed -i "/$def_ntp/d" $FILE
echo "$new_ntp" >> $FILE
#sed -i "5i$new_ntp" $FILE

cat /etc/ntp.conf > $PWD/st_ntp.conf

/etc/init.d/ntp restart

PWD=`pwd`
(cat /etc/crontab | grep ntp_verify.sh) || echo "* * * * * root $PWD/ntp_verify.sh" >> /etc/crontab

