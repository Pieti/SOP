from scipy import signal
from scipy.io import wavfile
import matplotlib.pyplot as plt
import numpy as np


def plotAll(f,t,Sxx, fs, audio, ylimits = 0, xlimits = 0):
    plt.subplot(2,1,1)
    audio_sampletimes = range(len(audio))
    x_axis = [i / fs for i in audio_sampletimes]

    if xlimits:
        plt.xlim(xlimits)
    plt.plot(x_axis, audio)
    plt.xlabel('Time (micro seconds)')
    plt.ylabel('Amplitude')

    plt.subplot(2,1,2)
    plt.pcolormesh(t, f, Sxx)
    if ylimits:
        plt.ylim(ylimits)
    if xlimits:
        plt.xlim(xlimits)
    plt.ylabel('Frequency [Hz]')
    plt.xlabel('Time [sec]')
    plt.show()


def plotSpectrogram(f,t,Sxx):
    plt.pcolormesh(t, f, Sxx)
    plt.ylabel('Frequency [Hz]')
    plt.xlabel('Time [sec]')
    plt.show()

# Spectrogram variables
overlapBetweenSegments = 0
lengthOfFFT = 32
lengthOfSegment = 0 # Must be greater or equal to lengthOfFFT

# Time Limit in seconds
begin = 0 # start time
end = 6.7 # end time

timelimit = [begin, end]

if lengthOfSegment < lengthOfFFT:
    lengthOfSegment = lengthOfFFT

# Korvaa tämä omalla ääninäytteellä
audio_sample_location = r'C:\Koulu\aaninayte\OSR_us_000_0030_8k.wav'

fs, audio = wavfile.read(audio_sample_location)

f, t, Sxx = signal.spectrogram(audio, fs, nfft=lengthOfFFT, nperseg=lengthOfSegment, noverlap=overlapBetweenSegments)
print(fs)
#plotSpectrogram(f, t, Sxx)
plotAll(f, t, Sxx,fs, audio, xlimits=timelimit)

