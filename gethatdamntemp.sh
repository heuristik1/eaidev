#!/bin/bash
# a script to read and save temperature readings from all the group 28 1-wire temperature sensors
#  and output all readings from each time-point on a single line of a daily file
#
# setup
# path to temerature log files
TPATH="/usr/local/fdl/templogs/"
# character or characters to use as place marker for missing value (no spaces allowed)
PMARK="*"
# name of error log
ERRLOG="tmperr.log"
# create name for daily log file
DLOG=`date +"%d-%m-%Y.log"`
#
# put timestamp at start of each line of daily log file followed by a space (040 is octal for decimal 32)
echo -ne `date +"%H:%M:%S"`"\040" >> $TPATH$DLOG
#
# get all devices in the '28' family
FILES=`ls /sys/bus/w1/devices/w1_bus_master1/ | grep '^28'`
#
# iterate through all the devices
for file in $FILES
        do
        # get the 2 lines of the response from the device
        GETDATA=`cat /sys/bus/w1/devices/w1_bus_master1/$file/w1_slave`
        GETDATA1=`echo "$GETDATA" | grep crc`
        GETDATA2=`echo "$GETDATA" | grep t=`
        # get temperature
        TEMP=`echo $GETDATA2 | sed -n 's/.*t=//;p'`
        # test if crc is 'YES' and temperature is not -62 or +85
        if [ `echo $GETDATA1 | sed 's/^.*\(...\)$/\1/'` == "YES" -a $TEMP != "-62" -a $TEMP != "85000"  ]
                then
                # crc is 'YES' and temperature is not -62 or +85 - so save result
                # save to file named by sensor ID - comment out next line if this is not required
                echo `date +"%d-%m-%Y %H:%M:%S "`"$TEMP" >> $TPATH$file
                # convert temperature result (divide by 1000) - use 'bc' for floating point math
                TEMP=$(echo "scale=3; $TEMP / 1000.0" | bc)
                # save to daily file (just append to same line followed by space but no trailing new line character)
                echo "$file" "$TEMP"
                else
                # there was an error (crc not 'yes' or invalid temperature)
                # try again after waiting 1 second
                sleep .1
                # get the 2 lines of the response from the device again
                GETDATA=`cat /sys/bus/w1/devices/w1_bus_master1/$file/w1_slave`
                GETDATA1=`echo "$GETDATA" | grep crc`
                GETDATA2=`echo "$GETDATA" | grep t=`
                # get the temperature from the new response
                TEMP=`echo $GETDATA2 | sed -n 's/.*t=//;p'`
                if [ `echo $GETDATA1 | sed 's/^.*\(...\)$/\1/'` == "YES" -a $TEMP != "-62" -a $TEMP != "85000" ]
                        then
                        # save result if crc is 'YES' and temperature is not -62 or +85 - if not, just miss it and move on
                        # save to file named by sensor ID - comment out next line if this is not required
                        echo `date +"%d-%m-%Y %H:%M:%S "; echo $GETDATA2 | sed -n 's/.*t=//;p'` >> $TPATH$file
                        # convert temperature result (divide by 1000) - use 'bc' for floating point math
                        TEMP=$(echo "scale=3; $TEMP / 1000.0" | bc)
                        # save to daily file (just append to same line followed by space but no trailing new line character)
                        echo "$file" "$TEMP"
                        else
                        # put a place marker in the daily file to show missing value
                        echo "$PMARK" 
                fi
                # this is a retry so log the failure - record date/time & device ID
                echo `date +"%d-%m-%Y %H:%M:%S"`" . ""$file" >> $TPATH$ERRLOG
        fi
done
#
# put a new line character into daily file - ready for next set of data
echo >> $TPATH$DLOG
#
exit 0
