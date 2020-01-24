clc;
clear;
close all;
tic
addpath('./特征提取方法')
% 参数
file_dir = '.\right\';

% 列举文件夹下所有的文件
file_folder=fullfile(file_dir);
dirOutput=dir(fullfile(file_folder,'*.txt'));
file_names = {dirOutput.name};%file_names存放了所有txt文件全名
datas=zeros(10000,16,9);
i=1;
%%
%提取特征，保存
for file_name = file_names
    file_path = strcat(file_dir,file_name{1});
    data_with_time=load(file_path);
    a = ones(155,1) * i;%155为分窗后样本数
    datas(:,:,i) = data_with_time(:,1:16); % 删除时间戳,获得所有的处理好的数据
    datas_feature=[GetAAC(datas(:,:,i), 128, 64),a];%特征RMS，窗长128，步长64
   % datas_feature=[GetVAR(datas(:,:,i), 128, 64),a];
    datas_features{i}=datas_feature;
    %datas_features大小1*9，每个cell大小155*17(155为分窗样本数，17为16通道加标签，9为动作数)
    %均方根特征提取好了 
    i=i+1;
end
save datas_features.mat datas_features

%%
%合成整个训练数据集data_training大小1395*17
data_training=[];
[row, col] = size(datas_feature);
for j=1:9
    data_training = [data_training;datas_features{j}];
end
[m, n] = size(data_training);
num_train = fix(m * 0.5);%  50%用于训练
num_test = fix(m * 0.5);%  50%用于测试
%%
%除集成分类外，不同方法分类器训练与测试
%50次迭代，求平均计算的正确率
accuracy = zeros(50,1);
for i = 1:500
    num=0;
    %形成随机的训练集，训练集标签，测试集以及测试集标签
    
    choose = randperm(length(data_training));
    %choose对data_training的数据序号进行随机排列
    
    %训练集
    TrainData = data_training(choose(1:num_train),:);
    %，TrainData选择重拍列的（1~num_train）行
    TrainLabel = TrainData(:,end);%训练标签为最后一列数据
    TrainData = TrainData(1:num_train,1:col-1);%分离标签，得到纯特征数据
    
    %测试集
    TestData = data_training(choose(num_train+1:end),:);
    TestLabel = TestData(:,end);
    TestData = TestData(1:num_test,1:col-1);
    
%  1.LDA分类
   MdlLinear = fitcdiscr(TrainData,TrainLabel);%训练LDA学习器
   predict_label = predict(MdlLinear,TestData);%测试数据得到分类结果
    
% %  2.knn分类
%    mdl = fitcknn(TrainData,TrainLabel,'NumNeighbors',1);
%    predict_label= predict(mdl, TestData);

% %  3.SVM分类(多类分类：ECOC)
%    svm = fitcecoc(TrainData, TrainLabel);
%    predict_label=predict(svm, TestData);
 
% %  4.Bayes分类
%    nb = fitcnb(TrainData, TrainLabel);
%    predict_label=predict(nb, TestData);

% %  5.随机森林分类器（Random Forest）
%    nTree = 20;
%    RF = TreeBagger(nTree,TrainData,TrainLabel);
%    predict_label = predict(RF,TestData);
%    predict_label = str2double(predict_label);

% %  6.二叉决策树
%    tree = fitctree(TrainData, TrainLabel);
%    predict_label   = predict(tree, TestData);

%    %下面这个循环，计算分类正确的个数
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
% %  7.集成学习
%     num=0;
%     %形成随机的训练集，训练集标签，测试集以及测试集标签
%     
%     choose = randperm(length(data_training));
%     %choose对data_training的数据序号进行随机排列
%     
%     %训练集
%     TrainData = data_training(choose(1:num_train),:);
%     %，TrainData选择重拍列的（1~num_train）行
%     TrainLabel = TrainData(:,end);%训练标签为最后一列数据
%     TrainData = TrainData(1:num_train,1:col-1);%分离标签，得到纯特征数据
%     
%     %测试集
%     TestData = data_training(choose(num_train+1:end),:);
%     TestLabel = TestData(:,end);
%     TestData = TestData(1:num_test,1:col-1);
%     
% classificationEnsemble = fitensemble(...
%    TrainData, ...
%    TrainLabel, ...
%    'bag', ...%强分类器采用方法
%    500, ...%循环次数
%    'Tree', ...%弱分类器采用方法
%    'Type', 'Classification', ...
%    'ClassNames', [1; 2; 3; 4; 5; 6;7;8;9] ...%用于分类的类名
% );
% predict_label   = predict(classificationEnsemble, TestData);
%    for j = 1:num_test
%           if predict_label(j,1) == TestLabel(j,1)
%              num = num+1;
%           end 
%    end
% cpu_time = toc
% Accuracy=num/num_test


