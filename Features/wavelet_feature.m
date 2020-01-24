function feature_each = wavelet_feature(data_each,wavetype,num_dec,Fs)
    
    [~,num_channel] = size(data_each);
    for i_channel = 1:num_channel
        % �ֽ���ÿ��ͨ������������
        feature_each(:,i_channel) = wavelet_dec(data_each(:,i_channel),wavetype,num_dec,Fs);
    end
    
end