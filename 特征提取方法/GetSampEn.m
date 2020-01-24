function out = GetSampEn(X, window, WindowShift)

dim = size(X);

out_length = fix((dim(1)-window)/WindowShift+1);
out=zeros(out_length, dim(2));
out1=zeros(out_length, dim(2));
out2=zeros(out_length, dim(2));

r=[];
for i= 1:  size(X,2)
    r = [r 0.2*sqrt(var(X(:,i)))]; %对每个channel求取方差之后开方并乘以0.2
end

 for i= 1:out_length;
     
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:); %分别取数据段[1:300],[101:400],[201:500],...,[104701:105000],共1048段
     for j=1:size(X,2)
         %%对每一段数据分别调用SampEn进行计算，共计算1048次,原来的方法
        %out(i,j) =  SampEn(2,r(j),temp(:,j),1);  %耗时141.05秒
        out1(i,j) =  sampleEntropy(temp(:,j),2,r(j),1); %method from GITHUB，耗时103.45秒
        %out2(i,j) =  SampEn_new(temp(:,j),2,r(j)); %摘自matlab中文社区，耗时131.66秒
     end
     %i
 end
end
 
 