% Record Wow Measurement, using analytic signal
% using 1000 or 3150 track
% John Vanderkooy May 2021
% analysis order:test_freq,analytic_freq,200Hz_LP,decimate,,WF_weighting 
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
% 
%filename='lacquerA_sil_1kHz_beginning.wav';ts=17;tf=24.7;
filename='lacquerA_silence_1kHz.wav';ts=50;tf=90;
%
[tone,fs]=audioread(filename);%stereo
lr=1; %1=left, 2=right
disp(['left_right: ' num2str(lr)])
tone=tone(:,lr);%now mono
Nt=length(tone);
%%----------select useful portion------------
ns=round(ts*fs)+1;nf=round(tf*fs);
tone=tone(ns:nf);
Nt=length(tone);
t=(0:Nt-1)/fs;
f=(0:floor(Nt/2))'*fs/Nt;
disp(['N_analyze: ' num2str(Nt) '  duration: ' num2str(Nt/fs) '  fs: ' num2str(fs)])
%------------plot data------------
figure(20)
plot(t,tone(1:Nt),'b') 
grid on;
% axis([0 Nt/fs ylim])
xlabel('time[s]')
legend('left or right')
title('selected file data')
%-------------------get rough estimate of test freq--------------------
TONE=fft(tone);
[~,k]=max(abs(TONE(1:floor(Nt/2+1))));
test_freq=(k-1)*fs/Nt;
disp(['rough test freq [Hz]: ' num2str(test_freq)])
%------------------ analytic signal-------------
toneh=hilbert(tone);
phase=unwrap(angle(toneh));
freq=(1/(2*pi))*diff(phase)*fs;%length Nt-1
freq=[freq;test_freq];% revert to length Nt

analytic=freq(10000:10010)

[b,a]=butter(2,200*2/fs);
freq=filtfilt(b,a,freq);%this now has some end effects

lp_analytic=freq(10000:10010)

figure(40)
plot(t,freq)
grid on;
xlabel('Time[s]')
ylabel('Freq[Hz]')
axis([0 5 test_freq-5 test_freq+5])
title('analytic freq(t)')

%-----------------decimate helps VLF W&F filtering-----------
decfactor=10;%need fs=9600 for W&F weighting
%freq=decimate(freq,decfactor);%gives erroneous result for the average!!!
freq=sparsify(freq,decfactor);
%freq=resample(freq,1,decfactor);%probably has some DC error too!!!
fs=fs/decfactor;
Nt=length(freq);
t=(0:Nt-1)/fs;
f=(0:floor(Nt/2))*fs/Nt;
disp(['fs: ' num2str(fs) '  N_decimated: ' num2str(Nt) '  duration: ' num2str(Nt/fs)])
%---------------lowpass filter FM response--------------------
% [b,a]=butter(2,200*2/fs);
% freq=filtfilt(b,a,freq);%this now has some end effects
%----------------------------------------------------
figure(60)
plot(t,freq)
grid on;
xlabel('Time[s]')
ylabel('Freq[Hz]')
axis([0 5 test_freq-20 test_freq+20])
title('LP filtered freq(t)')

dec_analytic=freq(10000:10010)

%% -----------------------AES WF-wtg table-----------------------------------
fr=[0.1 0.2 0.315 0.4 0.63 0.8 1.0 2.0 4.0 6.3 10.0 20.0 40.0 63 100 200 1000];
dBWFtable=[-57 -30.6 -19.7 -15 -8.4 -6.0 -4.2 -0.9 0 -0.9 -2.1 -5.9 -10.4 -13.7 -17.3 -23.0 -36.0];
%-----------------------------------------------------------
%coefficients for use at fs=9600Hz, decimate has set that up
f1 = 11.0;%HF rolloff
f2 = 0.50;%LF rollup
f3 = 0.60;%LF rollup
f4 = 0.90;%LF rollup
WF4 = 1.10;%sets dB gain
X=[f1 f2 f3 f4 WF4];
%-------analog-digital W&F-weighting filter from filter convolution---------
NUM = X(5)*[(2*pi)^3*X(2)*X(3)*X(4) 0 0 0];% s^3 character
DEN = conv(conv(conv([1 2*pi*X(2)],[1 2*pi*X(3)]) ,[1 2*pi*X(4)]), [1 2*pi*X(1)]); 
% Bilinear transformation of analog design to get the digital filter. 
[b,a] = bilinear(NUM,DEN,fs);
[H,w]=freqz(b,a,Nt/2+1);

figure(80);
semilogx(fr,dBWFtable,'r');
grid on;hold on;
semilogx(f,20*log10(abs(H)),'b');
axis([fs/Nt,fs/2,-60,10])
legend('AES W&F-wtg table','z-filter','Location','Best')
xlabel('Frequency [Hz]')
ylabel('dB')
title('wow and flutter weighting');

%----------------remove DC from freq---------------------
ns=round(Nt/10);
nf=round(9*Nt/10);
freq=freq-sum(freq(ns:nf))/(nf-ns+1);% remove DC from WF sampled deviation array

nodc_analytic=freq(1000:1010)

%-----------------get fundamental wow or flutter amplitude---------
% 'freq': demodulated frequencies, sampled at fs, no DC, Nt points
FREQ=(1/0.2155)*(2/Nt)*fft(freq.*flattopwin(Nt));%extra factor for flattop
wfreqspecamplitude=max(abs(FREQ(10:round(Nt/2)-10)))%remove DC & Nyquist
R=70;%wow track radius in mm $$$$$$$$$$$$$$$$$$$$$$
centreholeoffsetmm=R*wfreqspecamplitude/test_freq %offset in mm
fw=(0:floor(Nt/2))*fs/Nt;%fft frequencies
%--------------apply W&F weighting---------------
WFfreq=filter(b,a,freq);%fs=9600Hz
figure(100)
plot(t,WFfreq)
grid on;
axis([0 5 -2 2])
xlabel('Time[sec]')
ylabel('Freq[Hz]')
title('weighted freq deviation')
%----------------characterize W&F result-----------------
freqrms=rms_response(freq(ns:nf));
disp(['rms unweighted freq variation [Hz]: ' num2str(freqrms)])
disp(['rms unweighted W&F: ' num2str(freqrms/test_freq)])
disp(' ')
%---------------now do WF weighted---------
WFrms=rms_response(WFfreq(ns:nf));
disp(['rms weighted freq variation [Hz]: ' num2str(WFrms)])
disp(['rms weighted W&F: ' num2str(WFrms/test_freq)])
disp('-------------------finished--------------------') 
