import numpy as np
import globals as GLB
import spidev, os, sys, math
from datetime import datetime
import RPi.GPIO as GPIO  # Import GPIO library
import time
import logging


class rester():
    
    def __init__(self):
        self.logger = logging.getLogger('root')
        self.createLogFilePath()
        self.initSPI()
        #Status Pin Definitions:
        Ycoilstat = 5
        Bcoilstat = 6
        Gcoilstat = 18
        Rcoilstat = 24
        #Control Pin Definitions:
        Ycontrol = 19
        Bcontrol = 20
        Gcontrol = 21
        Rcontrol = 26
        # Pin Setup:
        GPIO.setmode(GPIO.BCM) # Broadcom pin-numbering scheme
        # Set Status Pin to input
        GPIO.setup(Ycoilstat, GPIO.IN)
        GPIO.setup(Bcoilstat, GPIO.IN)
        GPIO.setup(Gcoilstat, GPIO.IN)
        GPIO.setup(Rcoilstat, GPIO.IN)
        # Set Control Pin to output
        GPIO.setup(Ycontrol, GPIO.OUT)
        GPIO.setup(Bcontrol, GPIO.OUT)
        GPIO.setup(Gcontrol, GPIO.OUT)
        GPIO.setup(Rcontrol, GPIO.OUT)
        #Time Variables
        bootdelay = 3600 # seconds
        charge2restdelay = 86400
        maxrest = .20 # 25% of Time in Service
        minrest = 7 days

    st
    def CoilState
 
#If we detect Low on the Status Pin, that means the Coil is Active and Engaged.  in  other words, the string is resting  IF we detect High, Active Not engaged.
#If we don't detect anything, that means it's not there. 

 
xCoil = array(Ycoil,Bcoil,Gcoil,Rcoil)
#somehow need to remove inactive coil from array here.
IF xCoil =! Null
xCoil in vArray
 
#the idea here is to calculate each active coil's rest state
Foreach String in vArray
 
IF Vx > 0 
If xStarttime null
xStarttime == now
Else
xResttime/xStarttime = xRestState
 
# return the lowest valued string
RestCoil =  np.amin(xRestState)

# At this point we rest string and write RestCoil to activeCoil Global Variables (to persist reboot)
If ActiveString != RestCoil
              Write ActiveString to PreviousRestString
               AND Write RestCoil to ActiveString
Else
              Continue

# now we set the pin to Low
If GPIO.input(restCoil,0) AND GPIO.input(restControl,1)
     GPIO.output(restControl,0)
Elseif 
   GPIO.input(restcoil,1) AND GPIO.input(restControl,0)
           Continue
Elseif
    #We need an alarm function if the string is in the wrong state.
    GPIO.input(restcoil,0) AND GPIO.input(restcontrol,1)
         ALARM
Elseif
    GPIO.input(restcoil,1) AND GPIO.input(restcontrol,1)
       GPIO.output(restControl,0)
#we need to talk the above section out a bit more, specifically about reboot persistence.

#last thing we need to do is log the durations to a file for each strings rest time.
#these durations are going to be used in the customer portal to show the amount of time each string has been rested.
