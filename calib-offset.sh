#!/bin/bash

if [ $HOSTNAME  = "nsb-002" ]
 then echo 0,0,0,0.141,-0.024 >/home/pi/calib/calibration

elif [ $HOSTNAME = "eai14104b" ]
 then echo 0,0,0,-0.47,-0.261>/home/pi/calib/calibration

elif [ $HOSTNAME = "eai158dae" ]
 then echo 0,0,0,-0.369,-0.415>/home/pi/calib/calibration

elif [ $HOSTNAME = "eai202dd3" ]
 then echo 0,0,0,0.145,0.281>/home/pi/calib/calibration

elif [ $HOSTNAME = "eai32e55a" ]
 then echo 0,0,0,-0.209,-0.32>/home/pi/calib/calibration


elif [ $HOSTNAME = "eai3d205b" ]
 then echo 0,0,0,0.951,0.429>/home/pi/calib/calibration

elif [ $HOSTNAME  = "eaia4b5a6" ]
 then echo 0,0,0,-0.116,-0.354>/home/pi/calib/calibration


elif [ $HOSTNAME  = "eaiac4dc9" ]
 then echo 0,0,0,0.652,0.506>/home/pi/calib/calibration

elif [ $HOSTNAME  = "EAID10143" ]
 then echo 0,0,0,0.42,0.536>/home/pi/calib/calibration
 
elif [ $HOSTNAME  = "eaid343e3" ]
 then echo 0,0,0,0.902,0.929>/home/pi/calib/calibration

elif [ $HOSTNAME  = "eaiee1ebb" ]
 then echo 0,0,0,-0.110,-0.154>/home/pi/calib/calibration

fi

