function [f,validationAccuracy] = SVMclassfier( A )
    %SVMclassfier ѵ���õ��ķ�����
    %   AΪ����ֵ��fΪ������ຯ��
    
    [response,prediect]=MyReshape(A);
    data=[response;prediect];
    data(isnan(data)) = 0;
    [trainedClassifier, validationAccuracy] = trainClassifier_adapt(data);
    f = trainedClassifier.predictFcn;
    
end

