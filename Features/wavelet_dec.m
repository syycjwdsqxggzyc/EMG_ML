function feature = wavelet_dec(data,wavetype,num_dec,Fs)
    
    feature = [];
    s = data;
    for i_dec = 1:num_dec
        % 采用dwt逐层分解
        % ca1/ca2等为低频系数,cd1/cd2等为高频系数
        [ca, cd] = dwt(s, wavetype); % dwt:1层小波分解，ca低频，cd高频
        % 提取第i_dec层分解的高频特征
        cd_max = max(cd);
        cd_min = min(cd);
        d_energy = sum(cd.^2)/(Fs/2)*2^i_dec; % 单位频率的能量
        feature = [feature,cd_max,cd_min,d_energy];
        % 更新分解数据，准备下一层分解
        s = ca;
    end
    % 提取最后一层分解的低频特征
    ca_max = max(ca);
    ca_min = min(ca);
    a_energy = sum(ca.^2)/(Fs/2)*2^num_dec; % 单位频率的能量
    feature = [feature,ca_max,ca_min,a_energy];
end