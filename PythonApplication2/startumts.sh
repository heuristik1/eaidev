#!/bin/sh
udevadm trigger
sleep 10
ATTID='19d2:0117'
VIETTELID1='19d2:0108'
VIETTELID2='19d2:0016'
MODEMID=`lsusb | grep ZTE | sed -e 's/.*ID//' | sed -e 's/ ZTE.*//'`
echo ${MODEMID}
if [ $MODEMID = $VIETTELID1 ]
then
/root/umtskeeper/umtskeeper --sakisoperators "USBDRIVER='option' OTHER='USBMODEM' USBMODEM='19d2:0108' APN='CUSTOM_APN' CUSTOM_APN='e-connect'  APN_USER='0' APN_PASS='0'" --sakisswitches "--sudo --console" --devicename 'ZTE' --statfilepath "/root/stats" --log --silent --sakisfaillockduration 3600 --monthstart 8 --nat 'no' --httpserver &>> /var/log/umtskeeper/error.log &
elif [ $MODEMID = $VIETTELID2 ]
then
/root/umtskeeper/umtskeeper --sakisoperators "USBDRIVER='option' OTHER='USBMODEM' USBMODEM='19d2:0016' APN='CUSTOM_APN' CUSTOM_APN='e-connect' APN_USER='0' APN_PASS='0'" --sakisswitches "--sudo --console" --devicename 'ZTE' --statfilepath "/root/stats" --log --silent --sakisfaillockduration 3600 --monthstart 8 --nat 'no' --httpserver &>> /var/log/umtskeeper/error.log &
elif [ $MODEMID = $ATTID ]
then
/root/umtskeeper/umtskeeper --sakisoperators "USBDRIVER='option' OTHER='USBMODEM' USBMODEM='19d2:0117' APN='broadband'  APN_USER='0' APN_PASS='0'" --sakisswitches "--sudo --console" --devicename 'ZTE' --statfilepath "/root/stats" --log --silent --sakisfaillockduration 3600 --monthstart 8 --nat 'no' --httpserver &>> /var/log/umtskeeper/error.log &
fi

