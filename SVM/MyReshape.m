function [response,prediect]=MyReshape(A)
prediect=[];
response=[];
for i =1:size(A,2) %i=1��9������
    tdata=A{i};
%     tdata(1,:,:)=[];
    tsize=size(tdata);%�õ�ÿ��������Ӧ�����Ĵ�С������tsize=18*16*156
    n=length(tsize);
    if n==2
        tsize(3)=1;
    end
    prediect=[prediect,reshape(tdata,[tsize(1)*tsize(2),tsize(3)])];
    response=[response,i*ones(1,tsize(3))];
end
end