clc; close all; clear all; 
set(0,'DefaultLineLineWidth',1.0);
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth',1.5)
addpath('/Users/cz/Code/vinyl-research/matlab_code/from_John')
addpath('/Users/cz/Code/vinyl-research/matlab_code/audio_functions')

fs = 96000;
Ns = 3*96000;


%-----------------------calculate logsweep-----------------------------%
f1=20;% end of turnon half-hann
f2=16000;%20000;

sweep=zeros(Ns,1);% initialize

time = [0:Ns,1]/fs;
time = time.';
time(end) = Ns/fs;
dt = time(2)-time(1);

FREQ = [];

% sweep = zeros(length(time),1);
% for i = (1:length(sweep))
%     freq = f1 + (f2-f1)/log10(Ns)*log10(i);
%     FREQ = [FREQ; freq];
%     sweep(i,:) = sin(2*pi*freq*time(i));
% end
% dt = 1/fs;

data = zeros(length(time),1);
data(1,:) = 1; 

[data_fft, freq] = audio_spectrum(data,96000,1,length(data));
% data_fft = sqrt(2/(fs*Ns))*data_fft;
% sweep = sin(2*pi.*FREQ.*time);
    % time = [1:Ns];
% sweep(1:Ns)=time*sin(2*pi*f_start*Ls*(exp(Ts/Ls)-1));% logsweep
% sweep(1,:)=1;
%-----------------------------------------------------------------------%

% [sweep, fs] = audioread('/Users/cz/OneDrive - University of Waterloo/School/Vinyl_Project/audio_bin/reference_files/digital_signals/sweep16kHz.wav');
% sweep = sweep(1*fs:35*fs,:)/max(sweep);


data_A = audio_Aweighting(data);
data_CCIR = audio_CCIRweighting(data);
% data_A = sqrt(2/(fs*Ns))*data_A;
% data_CCIR = sqrt(2/(fs*Ns))*data_CCIR;



% addpath('/Users/cz/Code/vinyl-research/matlab_code/from_John/July 9/')
% data_A2 = Aweighting_filter(sweep, fs);
% % data_CCIR = CCIRarm_filter(sweep, fs);
% [data_fftA2, freq] = audio_spectrum(data_A2, fs, 1, length(data_A2));


% figure(12)
% plot(time,FREQ)
% figure(11)
% plot(time,time)
figure(10)
% plot(time,sweep)
plot(time,data)

figure(1)
[data_fft, freq] = audio_spectrum(data_A, fs, 1, length(data_A));
data_fft = data_fft/sqrt(2/(fs*Ns));
plot(freq, 20.0*log10(abs(data_fft)),'k') 
grid on 
set(gca, 'XScale', 'log');
xlim([20,16000])
title('A Weighting Response')
xlabel('Frequency (Hz)')
ylabel('Level (dB)')  


figure(2)
[data_fftCCIR, freq] = audio_spectrum(data_CCIR, fs, 1, length(data_CCIR));
data_fftCCIR = data_fftCCIR/sqrt(2/(fs*Ns));

plot(freq, 20.0*log10(abs(data_fftCCIR)),'k') 
grid on 
set(gca, 'XScale', 'log');
title('CCIR Weighting Response')
xlim([20,16000])
xlabel('Frequency (Hz)')
ylabel('Level (dB)')  

figure(1)
[data_fftA, freq] = audio_spectrum(data_A, fs, 1, length(data_A));
data_fftA = data_fftA/sqrt(2/(fs*Ns));
plot(freq, 20.0*log10(abs(data_fftA)),'k') 
grid on 
set(gca, 'XScale', 'log');
xlim([20,16000])
title('A Weighting Response')
xlabel('Frequency (Hz)')
ylabel('Level (dB)')  


figure(3)
plot(freq, 20.0*log10(data_fftA)) 
hold on;
% plot(freq, 20.0*log10(data_fftA2)) 
plot(freq, 20.0*log10(data_fftCCIR))
grid on 
set(gca, 'XScale', 'log');
% title('CCIR Weighting Response')
title('Noise Weighting Responses')
legend('A-Weighting', 'CCIRarm-Weighting')
xlim([10,20000])
% ylim([-96,-40])
xlabel('Frequency (Hz)')
ylabel('Level (dB)')  