#!/bin/bash
logfile=/home/grimfoe/Desktop/Vagrant/Bash/access.log
errorlog=/var/log/apache2/error.log
oldlogfile=/home/grimfoe/Desktop/Vagrant/Bash/access.log.old
email=ktungod@gmail.com
tempfile=/var/log/text.txt


echo "-------------------Top IP List------------------" >> $tempfile
awk '{print $1}' $logfile | sort | uniq -c | sort -nr | head -n 10 >> $tempfile
echo "-------------------URL_TOP----------------------" >> $tempfile
egrep -o "htt(ps|p)://[a-z,A-Z,0-9,\.]*/" $logfile | uniq -c | sort -r >> $tempfile
echo "-------------------HTTP_Codes-------------------" >> $tempfile
awk '{print $9}' $logfile | sort | uniq -c | sort -nr | head -n 10 >> $tempfile
echo "-------------------ERRORS----------------------" >> $tempfile
egrep error $errorlog >> $tempfile

starttime='head -n 1 $logfile | egrep -o "[0-9]{2}/[A-Z][a-z]{2}/[0-9]{4}":[0-9]{2}:[0-9]{2}'
endtime='tail -n 1 $logfile | egrep -o "[0-9]{2}/[A-Z][a-z]{2}/[0-9]{4}":[0-9]{2}:[0-9]{2}'
cat $tempfile | mail -s "Apache log summary start: $starttime end: $endtime" $email

#cat $tempfile
cat $logfile >> $oldlogfile
rm $logfile
rm $tempfile



#ip_connections="awk '{ print $1}' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head -n 10"
#url_top="awk '{ print $11}' access.log | sort | uniq -c | sort -nr | head -n 10"
#codes="awk '{ print $9}' access.log | sort | uniq -c | sort -nr | head -n 10"

