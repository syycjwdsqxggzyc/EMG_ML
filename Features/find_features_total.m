function feature = find_features_total(data_sample)
    
    [~,~,num] = size(data_sample);
    
    % feature_relax: 37*8*num, num:sample number
    feature = [];
    
    for index = 1:num
         feature(:,:,index) = find_features(data_sample(:,:,index));
    end
    
end