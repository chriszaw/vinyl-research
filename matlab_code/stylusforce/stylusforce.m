clear all;close all;clc
set(0,'DefaultLineLineWidth',1.5);
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth',1.5)

addpath('audio')
addpath('/Users/cz/Code/vinyl-research/matlab_code/audio_functions')

% files = dir('/Users/cz/OneDrive - University of Waterloo/School/Vinyl_Project/audio_files/stylusforce/sf*.wav')
files = dir('/Volumes/AUDIOBANK/audio_files/stylusforce/*.wav')


[norm_file, fs] = audioread('/Volumes/AUDIOBANK/audio_files/stylusforce/normalization1.0g.wav');
% size(norm_file)
% 1/3*fs
% 2/3*fs
normalization = rms(norm_file(1/3*length(norm_file):2/3*length(norm_file),:))  %digital value of peak level


RMS_L = []
RMS_R = []
AS = []

k = 1;

% norm_file = '/Users/cz/OneDrive - University of Waterloo/School/Vinyl_Project/audio_files/antiskatetest/normalization.wav'

% [sig, fs] = audioread(norm_file);
% sigRMS=rms(sig);

% normalization=sqrt(2)*sigRMS*40/7; %digital value of peak level

for i = (1:length(files))
    filename = files(i).name
    file = strcat(files(i).folder,'/',filename)
    filename(3:5)
    as = str2num(filename(3:5))
    AS = [AS, as]
    
    [data, fs] = audioread(file); 
    data = data(1/3*length(data):2/3*length(data),:);
    data = audio_Aweighting(data);
    data(:,1)=data(:,1)/normalization(1);% now normalized to 40cm/s peak    
    data(:,2)=data(:,2)/normalization(2);% now normalized to 40cm/s peak 
    data = data((1/3)*fs:(2/3)*fs,:);
    data = audio_Aweighting(data);

    % data = data(5*fs:15*fs);

    rms_l = rms(data(:,1))
    rms_r = rms(data(:,2))

    RMS_L = [RMS_L, rms_l];
    RMS_R = [RMS_R, rms_r];
    % plot(data)

    % figure(2); hold on; 
    Nt = length(data)
    Rev4=abs(fft(data));
    f=[0:Nt/2]*fs/Nt;

    if contains(filename,'-1');
        figure(i+10); hold on
        length(f)
        floor(length(Rev4)/2 + 1)
        length(Rev4(1:length(Rev4)/2+1))
        audio_plotspectrum(f,Rev4(1:length(Rev4)/2+1),'Spectrum')
        grid on;
        figure(100)
        subplot(3,2,k)
        audio_plotspectrum(f,Rev4(1:length(Rev4)/2+1),num2str(as))
        xlim([1,22000])
        grid on;
        k = k+1;
    end


    % plot(tseg,freq)
    % grid on; hold on;
    % axis([0 5 ylim])
    % xlabel('Time[sec]')
    % ylabel('Freq[Hz]')
    % title('zoom freq(t)')

end
% RMS_L = audio_Aweighting(RMS_L)
% RMS_R = audio_Aweighting(RMS_R)

RMS_L = 20*log10(RMS_L)
RMS_R = 20*log10(RMS_R)

RMS = [RMS_L; RMS_R];
RMS = RMS.';



RMS2_L = [];
RMS2_R = [];
AS2 = [];
for i = (1:3:length(AS)-1);
    i
    AS2 = [AS2, AS(i)];
end
% AS = AS2

for i = (1:3:length(RMS)-1);
    i
    RMS2_L = [RMS2_L, (RMS_L(i) + RMS_L(i+1) + RMS_L(i+2))/2];
    RMS2_R = [RMS2_R, (RMS_R(i) + RMS_R(i+1) + RMS_R(i+2))/2];
    % RMS2(:,2) = [RMS2, (RMS(i,2) + RMS(i+1,2))/2];
end
RMS2_L = RMS2_L
RMS2_R = RMS2_R
RMS2 = [RMS2_L; RMS2_R]
size(AS.')
size(RMS_L.')
size(RMS_R.')

AS2.'
RMS2_L.'
RMS2_R.'
% size(RMS_L.')
% size(RMS_R.')
Tbl = table(AS2.',RMS2_L.',RMS2_R.')
% figure(100)
% plot(aS)
% figure(1)
% H = plot(AS2, RMS(:,1),'ko')
% hold on;
% H = plot(AS2, RMS(:,2),'kx')
% grid on;
% legend('RMS Left Channel', 'RMS Right Channel')
% xlabel('stylus force [g]')
% ylabel('RMS level [dB]')
% title('RMS noise vs stylus force')


figure(2)
H = plot(Tbl.Var1, Tbl.Var2,'ko')
hold on;
H = plot(Tbl.Var1, Tbl.Var2,'kx')
grid on;
legend('RMS Left Channel', 'RMS Right Channel')
xlabel('stylus force [g]')
ylabel('RMS level [dB]')
title('RMS noise vs averaged stylus force')


% figure(2)
% H = bar(AS, RMS, 'LineWidth', 2)
% % H = bar([RMS_L, RMS_R], 'LineWidth', 2)
% RMS_L
% RMS_R
% AS
% H(1).FaceColor = [0.6 0.6 0.6];
% H(2).FaceColor = [.9 .9 .9];
% grid on;
% legend('RMS Left Channel', 'RMS Right Channel')
% xlabel('anti skate setting')
% ylabel('RMS level [dB]')
% title('RMS noise vs anti skate')

% saveas(100,'quadspectrumAweighted.png')
% saveas(100,'quadspectrumAweighted.fig')
% saveas(2,'ASvsRMSAweighted.png')
% saveas(2,'ASvsRMSAweighted.fig')
