function out = GetZC(X, window, WindowShift, deadzone) 
%X��ԭʼ���ݣ�window�Ǵ��ڳ��ȣ�windowShift��ÿ�δ����ƶ�����
%deadzone: +/- zone signal must cross to be considered a deadzone

dim = size(X);
if window > dim(1);   %���ڳ��Ȳ��ܳ������ݳ��ȣ�����һ�μ��㶼�����ˣ�����ȡ100-300����
    error('The length of X should be longer than window');
end

out_length = fix((dim(1)-window)/WindowShift+1); %һ��ѭ������Ĵ���
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
    