
A=struct2cell(load('matlab'));
% A=struct2cell(load('feature_test'));
[response,prediect]=MyReshape(A);
data=[response;prediect];
data(isnan(data)) = 0;
% % 
% tic
% [trainedClassifier, validationAccuracy] = trainClassifier2(data);
% f=trainedClassifier.predictFcn;
% toc;
% % 
% B=struct2cell(load('feature_test'));
% [response2,prediect2]=MyReshape(B);
% prediect2(isnan(data)) = 0;
% result=f(prediect2)-response2';
% errorNum=sum(result~=0);
% errorPercent=errorNum/size(result,1)
% 
% 
