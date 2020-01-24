function [response,prediect]=MyReshape(A)
prediect=[];
response=[];
for i =1:size(A,2) %i=1：9动作数
    tdata=A{i};
%     tdata(1,:,:)=[];
    tsize=size(tdata);%得到每个动作对应特征的大小，这里tsize=18*16*156
    n=length(tsize);
    if n==2
        tsize(3)=1;
    end
    prediect=[prediect,reshape(tdata,[tsize(1)*tsize(2),tsize(3)])];
    response=[response,i*ones(1,tsize(3))];
end
end