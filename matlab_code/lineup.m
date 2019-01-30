%reference = 'correlation1.wav' %filename = 'correlation2.wav'
%
%
%[data_file, fs] = audioread(filename);
%[data_ref, fs] = audioread(reference);
%
%data_ref = data_ref((length(data_ref)/3):length(data_ref));
%data_file = data_file((length(data_file)/3):length(data_file));
%
%t_ref = (0:length(data_ref)-1)/fs;
%t_file = (0:length(data_file)-1)/fs;
%
%figure(2)
%subplot(2,1,1)
%plot(t_ref,data_ref)
%title('s_1')
%
%subplot(2,1,2)
%plot(t_file,data_file)
%title('s_2')
%xlabel('Time (s)')
%
%[acor,lag] = xcorr(data_file,data_ref);
%
%[~,I] = max(abs(acor));
%lagDiff = lag(I)
%
%timeDiff = lagDiff/fs
%
%figure(3)
%plot(lag,acor)
%
%cdata_file = data_file(-lagDiff+1:end);
%ct_file = (0:length(cdata_file)-1)/fs;
%
%figure(1)
%subplot(2,1,1)
%plot(t_ref,data_ref)
%title('s_1, aligned')
%xlim([0,1])
%subplot(2,1,2)
%
%plot(ct_file,cdata_file)
%title('s_2')
%xlabel('Time (s)')
%xlim([0,1])
%
%

%{
This code uses xcorr to lineup two audio files. The code above is the simplest use case, below it's been specialized
to work with multiple recordings of the same audio file and our groove plotting method.
%}

path_ref = '/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_files/1015_18_LiteToneTest/5.1.wav';
dir_files = '/Users/cz/OneDrive - University of Waterloo/Vinyl_Project/audio_files/1015_18_LiteToneTest/';
name_files = {['5.2.wav', '5.3.wav', '5.4.wav', '5.5.wav']}; 

AUDIO_FILES = {};

[data_ref, fs_ref] = audioread(path_ref);
time_ref = (0:length(data_ref)-1)/fs;
data_ref = data_ref(:,1);
size(data_ref)
AUDIO_FILES{1} = data_ref;
size(AUDIO_FILES)
size(name_files)
%~ Loop through all the files and line them up with the reference
for i = (1:length(name_files)); 
    strcat(dir_files,filename{i})
    [data_file, fs_file] = audioread(strcat(dir_files,filename{i}));
    time_file = (0:length(data_file)-1)/fs_ref; %Not sure if important, but here I'm using the 
                                             %fs of the reference file, I assume thats the right one
    
    data_file = data_file(:,1);
%    
%    figure(1)
%    subplot(2,1,1)
%    plot(time_ref,data_ref)
%    title('s_1')
%    
%    subplot(2,1,2)
%    plot(time_file,data_file)
%    title('s_2')
%    xlabel('Time (s)')
%
    
    [acor,lag] = xcorr(data_file,data_ref);
    [~,I] = max(abs(acor));
    lagDiff = lag(I)
    timeDiff = lagDiff/fs_ref
    cdata_file = data_file(-lagDiff+1:end);
    ct_file = (0:length(cdata_file)-1)/fs_ref;
   
    size(data_file)
    size(data_ref)
   
    AUDIO_FILES{i+1} = cdata_file; 
end

%~~~Segmenting Parameters~~~%
time = time_ref;
rotation_speed = 33.33333;%45;
T = 60/rotation_speed; %this is the length of one groove segment
n_sam = round(T*fs_ref)
time_seg = time(1:n_sam);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~%

%~~~~~PLOTTING~~~~~~%
seg_array = [];

figure(2);hold on;

for i=(1:length(AUDIO_FILES))
    data = AUDIO_FILES{i};
    num_segs = (floor(length(data)/fs_ref/T))
    for ng = 1:num_segs
        %seg_array(:,:,ng) = data(1+(ng-1)*n_sam:ng*n_sam,:);
        plot(time_seg,data(1+(ng-1)*n_sam:ng*n_sam,:));
 
    end    

end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~%
