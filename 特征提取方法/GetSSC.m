function out = GetSSC(X, window, WindowShift, threshold) %X是原始数据，window是窗口长度，windowShift是每次窗口移动距离

X=X(2:end-1,:)-X(1:end-2,:);
X1=X(2:end-1,:)-X(3:end,:);
dim = size(X1);
if window > dim(1);   %窗口长度不能超过数据长度，否则一次计算都不做了，建议取100-300测试
    error('The length of X should be longer than window');
end

for i=1:dim(1)
    for j=1:dim(2)
        if X(i,j)*X1(i,j)>=threshold
            X(i,j)=1;
        else
            X(i,j)=0;
        end
    end
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
     out(i,:) = sum(temp);
     %求数据和
 end
