clc;
clear;
close all;
tic
addpath('./������ȡ����')
% ����
file_dir = '.\right\';

% �о��ļ��������е��ļ�
file_folder=fullfile(file_dir);
dirOutput=dir(fullfile(file_folder,'*.txt'));
file_names = {dirOutput.name};%file_names���������txt�ļ�ȫ��
datas=zeros(10000,16,9);
i=1;
%%
%��ȡ����������
for file_name = file_names
    file_path = strcat(file_dir,file_name{1});
    data_with_time=load(file_path);
    a = ones(155,1) * i;%155Ϊ�ִ���������
    datas(:,:,i) = data_with_time(:,1:16); % ɾ��ʱ���,������еĴ���õ�����
    datas_feature=[GetAAC(datas(:,:,i), 128, 64),a];%����RMS������128������64
   % datas_feature=[GetVAR(datas(:,:,i), 128, 64),a];
    datas_features{i}=datas_feature;
    %datas_features��С1*9��ÿ��cell��С155*17(155Ϊ�ִ���������17Ϊ16ͨ���ӱ�ǩ��9Ϊ������)
    %������������ȡ���� 
    i=i+1;
end
save datas_features.mat datas_features

%%
%�ϳ�����ѵ�����ݼ�data_training��С1395*17
data_training=[];
[row, col] = size(datas_feature);
for j=1:9
    data_training = [data_training;datas_features{j}];
end
[m, n] = size(data_training);
num_train = fix(m * 0.5);%  50%����ѵ��
num_test = fix(m * 0.5);%  50%���ڲ���
%%
%�����ɷ����⣬��ͬ����������ѵ�������
%50�ε�������ƽ���������ȷ��
accuracy = zeros(50,1);
for i = 1:500
    num=0;
    %�γ������ѵ������ѵ������ǩ�����Լ��Լ����Լ���ǩ
    
    choose = randperm(length(data_training));
    %choose��data_training��������Ž����������
    
    %ѵ����
    TrainData = data_training(choose(1:num_train),:);
    %��TrainDataѡ�������еģ�1~num_train����
    TrainLabel = TrainData(:,end);%ѵ����ǩΪ���һ������
    TrainData = TrainData(1:num_train,1:col-1);%�����ǩ���õ�����������
    
    %���Լ�
    TestData = data_training(choose(num_train+1:end),:);
    TestLabel = TestData(:,end);
    TestData = TestData(1:num_test,1:col-1);
    
%  1.LDA����
   MdlLinear = fitcdiscr(TrainData,TrainLabel);%ѵ��LDAѧϰ��
   predict_label = predict(MdlLinear,TestData);%�������ݵõ�������
    
% %  2.knn����
%    mdl = fitcknn(TrainData,TrainLabel,'NumNeighbors',1);
%    predict_label= predict(mdl, TestData);

% %  3.SVM����(������ࣺECOC)
%    svm = fitcecoc(TrainData, TrainLabel);
%    predict_label=predict(svm, TestData);
 
% %  4.Bayes����
%    nb = fitcnb(TrainData, TrainLabel);
%    predict_label=predict(nb, TestData);

% %  5.���ɭ�ַ�������Random Forest��
%    nTree = 20;
%    RF = TreeBagger(nTree,TrainData,TrainLabel);
%    predict_label = predict(RF,TestData);
%    predict_label = str2double(predict_label);

% %  6.���������
%    tree = fitctree(TrainData, TrainLabel);
%    predict_label   = predict(tree, TestData);

%    %�������ѭ�������������ȷ�ĸ���
    for j = 1:num_test
           if predict_label(j,1) == TestLabel(j,1)
              num = num+1;
           end
    end
    accuracy(i,1) = num / num_test;
end
cpu_time = toc
Accuracy = mean(accuracy)

%%
% % 
% %  7.����ѧϰ
%     num=0;
%     %�γ������ѵ������ѵ������ǩ�����Լ��Լ����Լ���ǩ
%     
%     choose = randperm(length(data_training));
%     %choose��data_training��������Ž����������
%     
%     %ѵ����
%     TrainData = data_training(choose(1:num_train),:);
%     %��TrainDataѡ�������еģ�1~num_train����
%     TrainLabel = TrainData(:,end);%ѵ����ǩΪ���һ������
%     TrainData = TrainData(1:num_train,1:col-1);%�����ǩ���õ�����������
%     
%     %���Լ�
%     TestData = data_training(choose(num_train+1:end),:);
%     TestLabel = TestData(:,end);
%     TestData = TestData(1:num_test,1:col-1);
%     
% classificationEnsemble = fitensemble(...
%    TrainData, ...
%    TrainLabel, ...
%    'bag', ...%ǿ���������÷���
%    500, ...%ѭ������
%    'Tree', ...%�����������÷���
%    'Type', 'Classification', ...
%    'ClassNames', [1; 2; 3; 4; 5; 6;7;8;9] ...%���ڷ��������
% );
% predict_label   = predict(classificationEnsemble, TestData);
%    for j = 1:num_test
%           if predict_label(j,1) == TestLabel(j,1)
%              num = num+1;
%           end 
%    end
% cpu_time = toc
% Accuracy=num/num_test


