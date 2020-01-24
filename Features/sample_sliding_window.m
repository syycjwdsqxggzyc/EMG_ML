function data_sample_total = sample_sliding_window(data,window_width)
% This function uses a sliding window to sample a long data to several parts
% Input 
% data: a number(total length of data) * 16
% window_width: sliding window width 
% Output
% data_sample_total: XXX*16*n
    
    data_sample_total = [];
    window_pace = window_width/2;
    [row,col] = size(data);%原数据的维度大小
    
    index = 1;
    index_left = 1;
    index_right = index_left + window_width - 1;
    while(1)
        data_sample = data(index_left:index_right,:);
        data_sample_total(:,:,index) = data_sample;
        index_left = index_left + window_pace;
        index_right = index_left + window_width - 1;
        if(index_right >= row)
            index_right = row;
            index_left = index_right - window_width + 1;
            data_sample = data(index_left:index_right,:);
            data_sample_total(:,:,index + 1) = data_sample;
            break;
        end
        index = index + 1;
    end
end