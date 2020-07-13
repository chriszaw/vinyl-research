
function [data_fft, freq_fft] = audio_spectrum(data, fs, start_sam, n_sam);
    % data = hanning(length(data)).*data;
    disp('inside audio_spectrum')
    data_fft = fft(data(start_sam:start_sam+n_sam, :))/n_sam;
    data_fft = data_fft(1:n_sam/2+1);
    data_fft(2:end-1) = data_fft(2:end-1);

    freq_fft = fs*(0:(n_sam/2))/n_sam;

    size(freq_fft)
    size(data_fft)
    disp('finished audio_spectrum')
end %audio_spectrum

