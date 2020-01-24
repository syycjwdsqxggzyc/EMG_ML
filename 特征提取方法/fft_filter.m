function filter_data=fft_filter(input_data,low_f,high_f,delt)
%FFT_FILTER  Discrete Fourier Transform Filter
%    FILTER_DATA = FFT_FILTER (INPUT_DATA,LOW_F,HIGH_F,DELT)
%    The the vector INPUT_DATA (length N) is filtered base on the discrete
%    Fourier transform.
%
%    INPUT_DATA is the time series of length N.
%    LOW_F is the lowest frequence which can pass the filtering,
%          if  LOW_F = 0, it is the low-pass filtering.
%    HIGH_F is the highest frequence which can pass the filtering,
%           if  HIGH_F = 999, it is the high-pass filtering.
%    DELT is amount of time between each INPUT_DATA value, 
%         i.e. the sampling time.
%    The data output is also the vector of length N.
%
%----------------------------------------------------------------------------
%   Copyright (C) 2006_2009, Song Dehai
%   Ocean University of China, Program in Physical Oceanography.
%   This software may be used, copied, or redistributed as long as it is not
%   sold and this copyright notice is reproduced on each copy made.  This
%   routine is provided as is without any express or implied warranties
%   whatsoever.
%--------------------------------------------------------------------------
%--
if nargin~=4
     error('input error')
     return
end
%
[row_data,column_data]=size(input_data);
N=max(row_data,column_data);
if low_f==0
    fj=0;
else
    fj=low_f;
end
if high_f==999
    fk=1/delt;
else
    fk=high_f;
end
jj=max(fix(fj*N*delt),1);
kk=min(fix(fk*N*delt),N);

%Discrete Fourier transform
bf=fft(input_data-mean(input_data),N);

wm=zeros(row_data,column_data);
wm(jj:kk)=2*bf(jj:kk);

%Inverse discrete Fourier transform.
fwm=ifft(wm,N);

filter_data=mean(input_data)+real(fwm);

end