from scipy import signal
import scipy.io.wavfile as wav
import matplotlib.pyplot as plt
import numpy as np

audio_sample_location = r'C:\Koulu\aaninayte\OSR_us_000_0030_8k.wav'

fs, audio = wav.read(audio_sample_location)
"""
N = 1e5
amp = 2 * np.sqrt(2)
noise_power = 0.001 * fs / 2
time = np.arange(N) / fs
freq = np.linspace(1e3, 2e3, N)
x = amp * np.sin(2*np.pi*freq*time)
x += np.random.normal(scale=np.sqrt(noise_power), size=time.shape)
"""
f, t, Sxx = signal.spectrogram(audio, fs)
plt.pcolormesh(t, f, Sxx)
plt.ylabel('Frequency [Hz]')
plt.xlabel('Time [sec]')
plt.show()
