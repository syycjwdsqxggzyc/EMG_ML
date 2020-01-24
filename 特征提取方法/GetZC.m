function out = GetZC(X, window, WindowShift, deadzone) 
%X是原始数据，window是窗口长度，windowShift是每次窗口移动距离
%deadzone: +/- zone signal must cross to be considered a deadzone

dim = size(X);
if window > dim(1);   %窗口长度不能超过数据长度，否则一次计算都不做了，建议取100-300测试
    error('The length of X should be longer than window');
end

out_length = fix((dim(1)-window)/WindowShift+1); %一共循环计算的次数
out=zeros(out_length, dim(2));

for i= 1:out_length;
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:);
     for k=1:16;
         value=0;
         for j = 2:WindowShift;
             if abs(temp(j,k) - temp(j-1,k)) > deadzone && temp(j,k)* temp(j-1,k) < 0
                 value = value + 1;
             end
         end
         out(i,k)=value/WindowShift;
     end
end
    