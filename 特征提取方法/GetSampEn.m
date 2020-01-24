function out = GetSampEn(X, window, WindowShift)

dim = size(X);

out_length = fix((dim(1)-window)/WindowShift+1);
out=zeros(out_length, dim(2));
out1=zeros(out_length, dim(2));
out2=zeros(out_length, dim(2));

r=[];
for i= 1:  size(X,2)
    r = [r 0.2*sqrt(var(X(:,i)))]; %��ÿ��channel��ȡ����֮�󿪷�������0.2
end

 for i= 1:out_length;
     
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:); %�ֱ�ȡ���ݶ�[1:300],[101:400],[201:500],...,[104701:105000],��1048��
     for j=1:size(X,2)
         %%��ÿһ�����ݷֱ����SampEn���м��㣬������1048��,ԭ���ķ���
        %out(i,j) =  SampEn(2,r(j),temp(:,j),1);  %��ʱ141.05��
        out1(i,j) =  sampleEntropy(temp(:,j),2,r(j),1); %method from GITHUB����ʱ103.45��
        %out2(i,j) =  SampEn_new(temp(:,j),2,r(j)); %ժ��matlab������������ʱ131.66��
     end
     %i
 end
end
 
 