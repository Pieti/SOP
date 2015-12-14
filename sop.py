#!/usr/bin/env python3

import speech_recognition as sr
from gtts import gTTS
import subprocess


# obtain audio from the microphone
r = sr.Recognizer()
with sr.Microphone() as source:
	print("Sano jottain!")
	audio = r.listen(source)

#recognize speech using Google Speech Recognition 
try:
	audio_string = r.recognize_google(audio)
	print("Google Speech Recognition thinks you said " + audio_string)
except sr.UnknownValueError:
    print("Google Speech Recognition could not understand audio")
except sr.RequestError as e:
    print("Could not request results from Google Speech Recognition service; {0}".format(e))
<<<<<<< HEAD

text = "I think you said " + audio_string
subprocess.call('echo '+text+'|festival --tts', shell=True)
