function median_frequency = find_median_frequency(fre_fft,single_amp)
    
    % use bisection method to find the median frequency
    index_left = 1;
    index_right = length(fre_fft);
    index = ceil((index_left + index_left)/2);
    while(1)
        sum_left = sum(single_amp(1:index-1));
        sum_right = sum(single_amp(index+1:end));
        if(index_left == index_right)
            break
        elseif(abs(index_left-index_right)==1)
            error_left = sum(single_amp(1:index_left-1))-sum(single_amp(index_left+1:end));
            error_right = sum(single_amp(1:index_right-1))-sum(single_amp(index_right+1:end));
            if(error_left<error_right)
                index = index_left;
            else
                index = index_right;
            end
            break
        else
            if(sum_left < sum_right)
                index_left = index;
            else
                index_right = index;
            end
            index = ceil((index_left + index_right)/2);
        end
    end
    median_frequency = fre_fft(index);
end