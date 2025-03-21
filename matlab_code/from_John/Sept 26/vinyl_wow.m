% Record Wow Measurement
% using 3150 track
% John Vanderkooy
% April 2019
%  
clear all; clc;close all;
disp('----------------start of program--------------------')
set(0,'DefaultLineLinewidth',1.5)
set(0,'DefaultAxesFontSize',12)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth',1.5)
%
try
    pkg load signal %for Octave
catch
end

%filename='JV3150-96-AG33250A.wav';ts=0;tf=60;
% filename='Mann3150-96-AG33250A.wav';ts=0;tf=60;
% filename='JV3150-96-DS345.wav';ts=0;tf=60;
% filename='Mann3150-96-DS345.wav';ts=0;tf=60;
% 
filename='wow3150oscillator.wav';ts=10;tf=60;
% filename='wow3150funcgen.wav';ts=10;tf=60;
% filename='1kHz_DualPre.wav';ts=0;tf=50;
% 
%filename='lacquerA_sil_1kHz_beginning.wav';ts=17;tf=24.7;
%filename='lacquerA_silence_1kHz.wav';ts=50;tf=90;
% 
% filename='052319_pioneer3150.wav';ts=30;tf=70;% tts=30;ttf=70;
% filename='wow3150innerJ15aDual.wav';ts=8;tf=58;

% filename='r27wow0deg.wav';ts=10.0;tf=60.0;
% filename='r27wow90deg.wav';ts=25.0;tf=75.0;
% filename='r27wow180deg.wav';ts=10.0;tf=60.0;
% filename='r27wow270deg.wav';ts=20.0;tf=70.0;
% filename='r27wowinner270deg.wav';ts=10.0;tf=60.0;
addpath('/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_bin/at_Viryl')

folder = ('Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_bin/at_Viryl/')
% filename = 'virylableton28a(48kHz).wav'; ts=200,tf=245; %outer wow track
% filename = 'virylableton28a(48kHz).wav'; ts=717,tf=764; %inner wow track
% filename = 'viryltechnics-lacquer1st.wav'; ts=200,tf=245;
% filename = 'abletonlacquer1.wav'; ts=230,tf=280;
% filename = 'abletonlacquer2.wav'; ts=220,tf=270;
addpath('Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_bin/A0000B0000/')
folder = ('/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_bin/A0000B0000/');
% filename = '03141_A0000B0000r28a.wav';ts=202; tf=251;  %outer wow track
filename = '03141_A0000B0000r28a.wav';ts=720;tf=768;  %inner wow track


strcat(folder, filename)
[rev4_1,fs]=audioread(strcat(folder, filename));
lr=1; %1=left, 2=right
disp(['lr: ' num2str(lr)])
Nt=length(rev4_1);
disp(['fs: ' num2str(fs) '  N_total: ' num2str(Nt) '  duration: ' num2str(Nt/fs)])
t=linspace(0,(Nt-1)/fs,Nt)';%column vector
%-----------------prefiltering-----------
[b,a]=butter(2,2*100/fs,'high');% not really necessary with fft filter
%rev4_1=filter(b,a,rev4_1);
%-------------------plot all data------------
figure(20)
plot(t,rev4_1(1:Nt,lr),'b') 
grid on;
% axis([0 Nt/fs ylim])
xlabel('time[s]')
legend('left or right')
title('untrimmed file data')
%----------select useful portion------------
ns=round(ts*fs)+1;nf=round(tf*fs);
rev4_1=rev4_1(ns:nf,lr);% after this the lr dimension is gone
Nt=length(rev4_1);
disp(['N_analyze: ' num2str(Nt) '  duration: ' num2str(Nt/fs)])
%-----------------plots------------
f=[0:Nt/2]*fs/Nt;
%Rev4=abs(fft(window(@blackmanharris,Nt,'periodic').*rev4_1));
Rev4=abs(fft(rev4_1));
figure(30)
plot(f,20*log10(Rev4(1:Nt/2+1)),'b');
grid on;
xlabel('freq[Hz]')
ylabel('Power Spectrum [dB]')
legend('N_t data','Location','Best');
title('PSD')
%-------------------get rough estimate of test freq--------------------
[M,I]=max(Rev4(1:Nt/2+1));
freq_ref=(I-1)*fs/Nt
%------------------section spectra, get weighted line freq-------------
nfft=2^12 ;disp(['nfft: ' num2str(nfft)]) %not critical
fractional_bin=1+freq_ref*nfft/fs
nref=1+round((freq_ref/fs)*nfft);%freq bin nearest reference
nseg=floor(2*Nt/nfft-1);
w=window(@blackmanharris,nfft,'periodic');
n_sum=7;% a blackmanharris window allows smaller range
for k=1:nseg
    rev=w.*rev4_1((k-1)*nfft/2+1:(k+1)*nfft/2);
    Prev=abs(fft(rev)).^2;% power in each bin
    P(k)=0;Pw(k)=0;%initialize power and weighted power sums
    for p=-n_sum:n_sum
        % k
        % p 
        % nref
        P(k)=P(k)+Prev(nref+p);
        Pw(k)=Pw(k)+Prev(nref+p)*(nref-1+p)*fs/nfft;
    end
    freq(k)=Pw(k)/P(k);%power weighted frequency average
end
freq(1)=freq(3);freq(2)=freq(3);%%%%%% 2i2 seems to need this %%%%%%%%%%
tseg=[0:nseg-1]*(nfft/2)/fs;
figure(40)
plot(tseg,freq)
grid on;
xlabel('Time[sec]')
ylabel('Freq[Hz]')
%axis([xlim 3149.9932 3149.9938])
axis([xlim ylim])
title([filename ' ref:' num2str(freq_ref) ' nsum:' num2str(n_sum)])
%-------------closeup plot--------
figure(50)
plot(tseg,freq)
grid on;
axis([0 5 ylim])
xlabel('Time[sec]')
ylabel('Freq[Hz]')
title([filename ' ref:' num2str(freq_ref) ' nsum:' num2str(n_sum)])
disp('-------------------finished--------------------') 
