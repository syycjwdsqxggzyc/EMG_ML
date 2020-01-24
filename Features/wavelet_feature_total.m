function features = wavelet_feature_total(data_sample,wavetype)
    
    [~,~,num_sample] = size(data_sample);
    Fs = 1000;
    num_dec = 5;
    
    features = [];
    for i_sample = 1:num_sample
        % 分别求每个样本的特征向量
        data_each = data_sample(:,:,i_sample);
        feature_each = wavelet_feature(data_each,wavetype,num_dec,Fs);
        features(:,:,i_sample) = feature_each;
    end
    
end