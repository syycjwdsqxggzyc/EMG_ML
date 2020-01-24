function out = GetWL(X, window, WindowShift) %X是原始数据，window是窗口长度，windowShift是每次窗口移动距离

dim = size(X);
if window > dim(1);   %窗口长度不能超过数据长度，否则一次计算都不做了，建议取100-300测试
    error('The length of X should be longer than window');
end


out_length = fix((dim(1)-window)/WindowShift+1); %一共循环计算的次数
out=zeros(out_length, dim(2));

%假定window=300，windowShift=100,下述循环将会按照如下过程计算：
%1-299行减去2-300行计算绝对值的和并填充到out的第一行，移动100
%101-39行减去102-300行计算绝对值的和并填充到out的第二行，移动100
%201-499行减去202-500行计算绝对值的和并填充到out的第三行，移动100
%以此类推，形成的out一共有（总行数-300）/100+1 行
 for i= 1:out_length;
     index = (i-1)*WindowShift+1; 
     temp = X(index:(index+window-1),:);
     temp2 = temp(2:end,:); 
     out(i,:) = sum(abs(temp(1:end-1,:) - temp2));
      %|x1-x2|+|x2-x3|+....+|xn-1 - xn|
 end
