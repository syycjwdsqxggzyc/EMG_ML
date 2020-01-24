function out = GetVAR(X, window, WindowShift) %X是原始数据，window是窗口长度，windowShift是每次窗口移动距离

dim = size(X);
if window > dim(1); %窗口长度不能超过数据长度，否则一次计算都不做了，建议取100-300测试
    error('The length of X should be longer than window');
end

out_length = fix((dim(1)-window)/WindowShift+1); %一共循环计算的次数
out=zeros(out_length, dim(2));

%假定window=300，windowShift=100,下述循环将会按照如下过程计算：
%1-300行计算均值填充到out的第一行，移动100
%100-400行计算均值填充到out的第二行，移动100
%200-500行计算均值填充到out的第三行，移动100
%以此类推，形成的out一共有（总行数-300）/100+1 行
 for i= 1:out_length;
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:);
     out(i,:) = (sum(abs(temp)))/(window-1);
     %sum(|x|)
     %除n-1
 end