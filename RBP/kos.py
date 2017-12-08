from uuid import getnode
import json
import RPi.GPIO as GPIO
import time
import pyrebase
import firebase_admin
from firebase_admin import credentials

config = {
	"apiKey": "AlzaSyDX19wtQEpULBLgxnisPqN7iFUF8TTvhP0",
	"authDomain": "smart-trash-78dcb.firebaseapp.com",
	"databaseURL": "https://smart-trash-78dcb.firebaseio.com",
	"storageBucket": "smart-trash-78dcb.appspot.com"
}

firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
db = firebase.database()

GPIO.setmode(GPIO.BCM)

TRIG = 23
ECHO = 24

name = getnode()
print(str(hex(name)))

GPIO.setup(TRIG, GPIO.OUT)
GPIO.setup(ECHO, GPIO.IN)

GPIO.output(TRIG, False)
time.sleep(2)
GPIO.output(TRIG, True)
time.sleep(0.00001)
GPIO.output(TRIG, False)

while GPIO.input(ECHO)==0:
	pulse_start = time.time()
	
while GPIO.input(ECHO)==1:
	pulse_end = time.time()
	
pulse_duration = pulse_end - pulse_start
print(str(pulse_duration))

data = {
	"id" : str(hex(name)),
	"duration": str(pulse_duration)
}

fResult = db.child("reading").push(data)
