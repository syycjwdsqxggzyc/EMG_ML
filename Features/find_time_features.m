function feature_vector_time = find_time_features(data_sample)
    % Input 
    % data_sample: XXX*16
    % Output
    % feature_vector_fre: 26*16
    
    me = mean(data_sample); %��ֵ
    rm = rms(data_sample); %������ֵ
    av = mean(abs(data_sample)); %����ֵ��ƽ��ֵ(����ƽ��ֵ)
    st = std(data_sample);	%��׼��
    figure(10);
    for i=1:16
        se(i) = SampEn(data_sample(:,i),2,.25*st(i)); %������
        nbins=16;
        h = histogram(data_sample(:,i),nbins);
        hisv(:,i)=h.Values; % ֱ��ͼ����
        zcr(i)=getZCR(data_sample(:,i));%�������
        mcr(i)=getZCR(data_sample(:,i)-me(i));%����ֵ����
        xcor=xcorr(data_sample(:,i));
        cor(i)=xcor(floor(end*3/4)); %�ӳ�0.25��������ϵ��
    end
    close(gcf);
    mi = min(data_sample); %��Сֵ ��ֱ������ֵ
    ma = max(data_sample);  %���ֵ ��ֱ������ֵ
    pk = ma-mi;	%��-��ֵ
    t=mode(data_sample); %����
    feature_vector_time=[me;rm;av;st;se;hisv;zcr;mcr;cor;pk;t];
    
end