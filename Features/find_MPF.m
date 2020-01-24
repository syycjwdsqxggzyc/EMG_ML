function MPF = find_MPF(fre_fft,PSD_abs,len_data)
    
    % find mean power frequency (MPF)
    MPF_denominator=(sum(PSD_abs(1:len_data/2-1))+sum(PSD_abs(1:len_data/2)))/2;
    MPF_numerator=(sum(PSD_abs(1:len_data/2-1).*fre_fft(1:len_data/2-1))+sum(PSD_abs(1:len_data/2).*fre_fft(1:len_data/2)))/2;
    MPF = MPF_numerator/MPF_denominator;
    
end