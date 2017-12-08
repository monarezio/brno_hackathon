from uuid import getnode
import json
import RPi.GPIO as GPIO
import time
import pyrebase
import firebase_admin
from firebase_admin import credentials
import datetime

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

def take_reading():
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
	return pulse_duration
time.sleep(3)
print("ready")
first_reading = take_reading()

def reading_loop():
	current_reading = take_reading()
	percentage = 100 - ((current_reading / first_reading) * 100)

	data = {
		"timestamp" : str(datetime.datetime.now()),
		"percentage" : str(percentage)
	}

	fResult = db.child("reading").child(str(hex(name))).push(data)
	
while True:
	time.sleep(3)
	reading_loop()
