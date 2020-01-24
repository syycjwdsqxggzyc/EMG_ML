function out = GetSSC(X, window, WindowShift, threshold) %X��ԭʼ���ݣ�window�Ǵ��ڳ��ȣ�windowShift��ÿ�δ����ƶ�����

X=X(2:end-1,:)-X(1:end-2,:);
X1=X(2:end-1,:)-X(3:end,:);
dim = size(X1);
if window > dim(1);   %���ڳ��Ȳ��ܳ������ݳ��ȣ�����һ�μ��㶼�����ˣ�����ȡ100-300����
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

out_length = fix((dim(1)-window)/WindowShift+1); %һ��ѭ������Ĵ���
out=zeros(out_length, dim(2));

%�ٶ�window=300��windowShift=100,����ѭ�����ᰴ�����¹��̼��㣺
%1-299�м�ȥ2-300�м������ֵ�ĺͲ���䵽out�ĵ�һ�У��ƶ�100
%101-39�м�ȥ102-300�м������ֵ�ĺͲ���䵽out�ĵڶ��У��ƶ�100
%201-499�м�ȥ202-500�м������ֵ�ĺͲ���䵽out�ĵ����У��ƶ�100
%�Դ����ƣ��γɵ�outһ���У�������-300��/100+1 ��
 for i= 1:out_length;
     index = (i-1)*WindowShift+1;
     temp = X(index:(index+window-1),:);
     out(i,:) = sum(temp);
     %�����ݺ�
 end
