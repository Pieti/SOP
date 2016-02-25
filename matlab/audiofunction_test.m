% Ottaa syˆtteen‰ wav tiedoston  
% Tekee LPF suodatuksen
% Downsamplaa (Olettaa taajudeksi 44.1kHz ja downsamplaa kahdella)
% normalisoi amplitudin
% Tekee random spektrogrammin


clear;
% Variables
time_start = 5; % audioread start and end time in seconds
time_end = 7; 

% ShowPlots (1 = true, 0 = false)
plotSoundNSpectrum = 1;
plotSpectrogram = 1;

% Get audio info (samplerate)
fpath = 'D:\Koulu\matlab\SKN12a_Salla.wav'
info = audioinfo(fpath);
fs = info.SampleRate;

sample_start = round(fs * time_start + 1);
sample_end = round(fs * time_end + 1);
plotinterval = (time_end - time_start)/(sample_end - sample_start);
samples = [sample_start, sample_end]; 

% timeline for plot
t = time_start:plotinterval:time_end;

% Read audio
[y, fs] = audioread(fpath, samples);

% Read filter
load('filt','sos','g');

% Filtered audio
orig_y = y;
orig_t = t;
orig_sample_start = sample_start;
orig_sample_end = sample_end;

y = sosfilt(sos, y); % Use filter (antialiasing)

y = downsample(y,2); % Downsample
fs = round(fs/2); % fs/2 and roundup

%normalization [0, 1] (min(y)=0 max(y)=1)
% En tied‰ onko tarpeeksi hyv‰, pit‰isi olla nolla keskiarvoinen v‰lill‰ 
% [-1, 1]
y = (y - mean(y)) / max(abs((y - mean(y))));

% update data areas
sample_start = round(fs * time_start + 1);
sample_end = round(fs * time_end + 1);
plotinterval = (time_end - time_start)/(sample_end - sample_start);
samples = [sample_start, sample_end]; 
t = time_start:plotinterval:time_end;

sample_start = round(sample_start/2);
sample_end = round(sample_end/2);

% Print audio
if plotSoundNSpectrum
    figure
    soundplot = subplot(211);
    plot(t, y);
    title('Mean normalized audio');
end

Y = fft(y);
L = sample_end - sample_start;
if mod(L,2)
    L = L +1;
end
    
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

freq = fs*(0:(L/2))/L;

if plotSoundNSpectrum
    specplot = subplot(212);
    xlim(specplot, [0,fs/2]);
    plot(freq,P1)

    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
end

%spectrogram
% Kutsun t‰ss‰ vaiheessa viel‰ aika random arvoilla
% Pit‰‰ selvitt‰‰ miten t‰t‰ k‰ytet‰‰n, oikeink‰ytettyn‰ saadaan suoraan syˆte
% neuroverkolle?

s = spectrogram(y, 128, 120, 40, fs, 'yaxis');
if plotSpectrogram
    figure
    spectrogram(y, 128, 120, 40, fs, 'yaxis');
end

%{ 
% Soittaa valitun p‰tk‰n enterist‰, mutta on hanurista kun plotit j‰‰
% piiloon, eik‰ pysty seuraamaan miss‰ kohtaa on menossa

menu = 1;

player = audioplayer(y, fs);
while menu
    prompt = 'Play? Y/N [Y]: ';
    str = input(prompt,'s');

    if str == 'N';
        menu = 0;
        break;
    end
    play(player);
end
%}

%reaalinen cepstrum
 % Mielenkiintoisia ominaisuuksia
 % On k‰ytetty puheentunnistuksessa avuksi, mutten viel‰ ymm‰rt‰nyt miten.
 % Kaikua ainakin pystyt‰‰n poistamaan tarvittaessa.
%{
figure;
c = rceps(y);
plot(t,c)


%}

