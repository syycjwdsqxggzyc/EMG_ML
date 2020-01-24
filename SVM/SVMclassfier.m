function [f,validationAccuracy] = SVMclassfier( A )
    %SVMclassfier 训练得到的分类器
    %   A为特征值，f为输出分类函数
    
    [response,prediect]=MyReshape(A);
    data=[response;prediect];
    data(isnan(data)) = 0;
    [trainedClassifier, validationAccuracy] = trainClassifier_adapt(data);
    f = trainedClassifier.predictFcn;
    
end

