function [shape_mean,shape_std,shape_skew,shape_kurt,magnitude_mean,magnitude_std,magnitude_skew,magnitude_kurt] = find_shape_magnitude_features(PSD_abs,len_data)
    
    %   INPUT
    %   PSD_abs: 1*n
    %   OUTPUT
    %   shape_mean: 1*1
    %   shape_sd: 1*1
    %   shape_skew: 1*1
    %   shape_kurt: 1*1
    %   amp_mean: 1*1
    %   amp_sd: 1*1
    %   amp_skew: 1*1
    %   amp_kurt: 1*1
    
    index=(2:len_data/2+1)';
    psd = PSD_abs(index);
    clear index
    % psd = pwelch(data);
    [row_psd,column_psd] = size(psd);
    S = sum(psd);
    
    % shape feature
    temp = 0;
    for m = 1:column_psd
        temp = temp + m*psd(m);
    end
    shape_mean = temp/S;
    
    temp=0;
    for m=1:column_psd
        temp = temp+((m-shape_mean)^2)*psd(m);
    end
    shape_std = (temp/S)^0.5;
    
    temp=0;
    for m=1:column_psd
        temp = temp+(((m-shape_mean)/shape_std)^3)*psd(m);
    end
    shape_skew = temp/S;
    
    temp=0;
    for m=1:column_psd
        temp = temp+(((m-shape_mean)/shape_std)^4)*psd(m);
    end
    shape_kurt = temp/S-3;
    
    % magnitude feature
    magnitude_mean = mean(psd);
    magnitude_std = std(psd,0);
    magnitude_skew = skewness(psd,0);
    magnitude_kurt = kurtosis(psd,0);
    
end