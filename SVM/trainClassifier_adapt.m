function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)

% Convert input to table
inputTable = table(trainingData');
inputTable.Properties.VariableNames = {'row'};

featureNum=size(trainingData,1);
featureName = cellstr(reshape(sprintf('row_%03d',[1:featureNum]), [7,featureNum])')';

% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'row'})), array2table(table2array(inputTable(:,{'row'})), 'VariableNames', featureName)];
% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.

predictorNames=featureName;
predictorNames(1)=[];
predictors = inputTable(:, predictorNames);
response = inputTable.row_001;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationEnsemble = fitensemble(...
    predictors, ...
    response, ...
    'Bag', ...%分类器采用方法
    50, ...%循环次数
    'Tree', ...
    'Type', 'Classification', ...
    'ClassNames', [1; 2; 3; 4; 5; 6]);

%创建分类器结果结构
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
convertMatrixToTableFcn = @(x) table(x', 'VariableNames', {'row'});
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'row'})), array2table(table2array(t(:,{'row'})), 'VariableNames', featureName(2:end))];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(convertMatrixToTableFcn(x)));
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Convert input to table
inputTable = table(trainingData');
inputTable.Properties.VariableNames = {'row'};

inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'row'})), array2table(table2array(inputTable(:,{'row'})), 'VariableNames', featureName)];
% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames =featureName;
predictors = inputTable(:, predictorNames);
response = inputTable.row_001;


% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 2);
% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');