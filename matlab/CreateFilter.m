%

info = audioinfo('SKN12a_Salla.wav');
fs = info.SampleRate;

% Create filter
Fn  = fs/2;                                 % Nyquist Frequency
Fco =   10000;                                 % Passband (Cutoff) Frequency
Fsb =   11000;                                 % Stopband Frequency
Rp  =    1;                                 % Passband Ripple (dB)
Rs  =   10;                                 % Stopband Ripple (dB)
[n,Wn]  = buttord(Fco/Fn, Fsb/Fn, Rp, Rs);  % Filter Order & Wco
[b,a]   = butter(n,Wn);                     % Lowpass Is Default Design
[sos,g] = tf2sos(b,a);                      % Second-Order-Section For STability

% Check Filter Performance
figure
freqz(sos, 204, fs)                         
ylim([-50,100]);

% Save filter
save('filt','sos','g');