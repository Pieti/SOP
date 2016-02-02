from scipy import signal
from scipy.io import wavfile
import matplotlib.pyplot as plt
import os
import numpy as np

def getSpectrogram(audio, fs, lengthOfFFT=256, overlapBetweenSegments=64, xlimits=[0,0], freqlimits=[0,0], showPlot=False):
    if xlimits[0] == xlimits[1]:
        xlimits = False

    if freqlimits[0] == freqlimits[1]:
        freqlimits = False

    # Audio raw plot
    plt.subplot(2,1,1)
    audio_sampletimes = range(len(audio))
    x_axis = [i / fs for i in audio_sampletimes]
    if xlimits:
        plt.xlim(xlimits)
    plt.plot(x_axis, audio)
    plt.xlabel('Time (seconds)')
    plt.ylabel('Amplitude')

    #Spectrogram plot
    plt.subplot(2,1,2)
    Sxx, f, t, im = plt.specgram(audio, Fs=fs, NFFT=lengthOfFFT, noverlap = overlapBetweenSegments)
    plt.ylabel('Frequency [Hz]')
    plt.xlabel('Time [sec]')
    if xlimits:
        plt.xlim(xlimits)
    if freqlimits:
        plt.ylim(freqlimits)
    if showPlot:
        plt.show()
    return Sxx, f, t

if __name__ == "__main__":
    #Tiedosto polku (huomioi ubuntu?)
    location = 'audio\\'

    #Menu variables
    menustate = 0 # 0= init, 9= exit

    # Spectrogram variables
    showPlot = True
    overlapBetweenSegments = 256
    lengthOfFFT = 512
    lengthOfSegment = 0 # Must be greater or equal to lengthOfFFT
    if lengthOfSegment < lengthOfFFT:
        lengthOfSegment = lengthOfFFT

    # plot range in seconds
    begin = 0 # start time
    end = 0 # end time
    timelimit = [begin, end]

    # spec freq range in hertz
    low_limit = 0
    high_limit = 10000
    freqlimits = [low_limit, high_limit]

    while 1: # Tähän saa tehdä järkevän valikon, normaalisti tämän tiedoston funktioita kutsutaan ulkoa, joten main on vain devausta varten
        while 1:
            # Find wav files in current directory
            files = []
            print("#### FILES #####")
            for file in os.listdir(location):
                if file.endswith('.wav'):
                    files.append(file)
                    print(file)
            print("#################")
            audio_sample = input("Write name of sample or 9 to exit: ")
            if audio_sample == '9':
                menustate = 9
                break
            if not audio_sample.endswith('.wav'):
                audio_sample += '.wav'
            if (audio_sample in files):

                audio_sample = location + audio_sample
                #script_dir = os.path.dirname(__file__)

                break

        if menustate == 9:
            break

        fs, audio = wavfile.read(audio_sample)

        Sxx, f, t = getSpectrogram(audio, fs, lengthOfFFT=lengthOfFFT, overlapBetweenSegments=overlapBetweenSegments, showPlot=showPlot, xlimits=timelimit, freqlimits=freqlimits)


