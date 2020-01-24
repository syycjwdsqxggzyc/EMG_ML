function feature = wavelet_dec(data,wavetype,num_dec,Fs)
    
    feature = [];
    s = data;
    for i_dec = 1:num_dec
        % ����dwt���ֽ�
        % ca1/ca2��Ϊ��Ƶϵ��,cd1/cd2��Ϊ��Ƶϵ��
        [ca, cd] = dwt(s, wavetype); % dwt:1��С���ֽ⣬ca��Ƶ��cd��Ƶ
        % ��ȡ��i_dec��ֽ�ĸ�Ƶ����
        cd_max = max(cd);
        cd_min = min(cd);
        d_energy = sum(cd.^2)/(Fs/2)*2^i_dec; % ��λƵ�ʵ�����
        feature = [feature,cd_max,cd_min,d_energy];
        % ���·ֽ����ݣ�׼����һ��ֽ�
        s = ca;
    end
    % ��ȡ���һ��ֽ�ĵ�Ƶ����
    ca_max = max(ca);
    ca_min = min(ca);
    a_energy = sum(ca.^2)/(Fs/2)*2^num_dec; % ��λƵ�ʵ�����
    feature = [feature,ca_max,ca_min,a_energy];
end