function feature_vector_time = find_time_features(data_sample)
    % Input 
    % data_sample: XXX*16
    % Output
    % feature_vector_fre: 26*16
    
    me = mean(data_sample); %均值
    rm = rms(data_sample); %均方根值
    av = mean(abs(data_sample)); %绝对值的平均值(整流平均值)
    st = std(data_sample);	%标准差
    figure(10);
    for i=1:16
        se(i) = SampEn(data_sample(:,i),2,.25*st(i)); %样本熵
        nbins=16;
        h = histogram(data_sample(:,i),nbins);
        hisv(:,i)=h.Values; % 直方图数据
        zcr(i)=getZCR(data_sample(:,i));%过零点数
        mcr(i)=getZCR(data_sample(:,i)-me(i));%过均值点数
        xcor=xcorr(data_sample(:,i));
        cor(i)=xcor(floor(end*3/4)); %延迟0.25秒的自相关系数
    end
    close(gcf);
    mi = min(data_sample); %最小值 非直接利用值
    ma = max(data_sample);  %最大值 非直接利用值
    pk = ma-mi;	%峰-峰值
    t=mode(data_sample); %众数
    feature_vector_time=[me;rm;av;st;se;hisv;zcr;mcr;cor;pk;t];
    
end