function feature_vector_fre = find_frequency_features(data_sample)
    % Input 
    % data_sample: XXX*16
    % Output
    % feature_vector_fre: 11*16
    
    % 
    sample_frequency = 1000; % sample frequency
    [len_data,len_channel] = size(data_sample); % length of data
    t_total = len_data/sample_frequency; % sample total time
    t_sample = linspace(0,t_total,len_data); % sample time list
    
    % 
    data_fft_total = zeros(len_data,len_channel);
    double_amp_total = zeros(len_data,len_channel);
    single_amp_total = zeros(len_data/2+1,len_channel);

    % the frequency feature vector 
    feature_vector_fre = zeros(11,len_channel);
    
%     figure
    for index_channel = 1:len_channel
        % Draw Original Data
%         subplot(4,4,index_channel)
%         plot(t_sample,data_sample(:,index_channel),'-r');
%         ylim([-500 500]);
%         title(['Sample Original Data: Channel-', num2str(index_channel)]);
%         xlabel('t/seconds');ylabel('x(t)');
        
        % Draw Frequency Spectrum
        data_fft = fft(data_sample(:,index_channel)); % fft
        double_amp = abs(data_fft/len_data); % Double-Sided Amplitude Spectrum of X(t)
        single_amp = double_amp(1:len_data/2+1); 
        single_amp(2:end-1) = 2*single_amp(2:end-1); % Single-Sided Amplitude Spectrum of X(t)
        fre_fft = sample_frequency*(0:(len_data/2))/len_data; % Single-Sided Amplitude Spectrum of X(t)
%         subplot(4,4,index_channel+8)
%         plot(fre_fft,single_amp,'-r');
%         ylim([0 100]);
%         title(['Single-Sided Amplitude Spectrum: Channel-',num2str(index_channel)]);
%         xlabel('f (Hz)');ylabel('|X(f)|');
        
        data_fft_total(:,index_channel) = data_fft;
        double_amp_total(:,index_channel) = double_amp;
        single_amp_total(:,index_channel) = single_amp;
        
        % find Autocorrelation Function (ACF)
        ACF = xcorr(data_sample(:,index_channel),'unbiased');
        % find Power Spectral Density (PSD)
        PSD = fft(ACF);
        PSD_abs = (abs(PSD))'; 
        
        % Constract the frequency feature vector 
        % the 1st element: DC Component
        feature_vector_fre(1,index_channel) = data_fft(1);
        % the 2nd element: Median Frequency
        feature_vector_fre(2,index_channel) = find_median_frequency(fre_fft,single_amp);
        % the 3rd element: Mean Power Frequency (MPF)
        feature_vector_fre(3,index_channel) = find_MPF(fre_fft,PSD_abs,len_data);
        % the 4th~11th element: PSD features
        % the 4th~7th element: shape features
        % the 8th~11th element: magnitude features
        % PSD features list: [shape_mean,shape_std,shape_skew,shape_kurt,magnitude_mean,magnitude_std,magnitude_skew,magnitude_kurt]
        [shape_mean,shape_std,shape_skew,shape_kurt,magnitude_mean,magnitude_std,magnitude_skew,magnitude_kurt] = find_shape_magnitude_features(PSD_abs,len_data);
        feature_vector_fre(4:11,index_channel) = [shape_mean,shape_std,shape_skew,shape_kurt,magnitude_mean,magnitude_std,magnitude_skew,magnitude_kurt];    
    end
    
end