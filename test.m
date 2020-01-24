% 
clc;
clear;
close all;
tic

addpath('./Features')
addpath('./SVM')
% 参数
file_dir = '.\right\';
window_width = 128; % 窗长，一般为2的整数幂，步长默认为窗长一半
wave_type = 'db1'; % 小波类型

% 列举文件夹下所有的文件
file_folder=fullfile(file_dir);
dirOutput=dir(fullfile(file_folder,'*.txt'));
file_names = {dirOutput.name};%file_names存放了所有txt文件全名


%%
% 提取特征并存入features元组
% features为一个元组，共有8个元素，每个元素对应一个动作，每个动作存储的是18*16的特征值
% features的8个元素依次对应: eight,finger,fist,good,inner,ok,openpalm,outer,relax
i = 1;
for file_name = file_names%赋值
    %读取数据
    file_path = strcat(file_dir,file_name{1});%strcat字符串拼接得到完整路径
    data_with_time = load(file_path);
    data = data_with_time(:,1:16); % 删除时间戳
    %到这里为止，已经拿到了16通道的数据
    
    % 用自己的分窗函数进行数据分窗
    data_window = sample_sliding_window(data,window_width);
    %data是10000*16大小，滑动分窗（步长64）后返回128*16*156（156为划分为的样本数）
    
    % 提取特征值，可选择时域特征或小波特征
    % 时域特征计算时间较长，请耐心等待
     feature = find_features_total(data_window); %时频特征
    %feature = wavelet_feature_total(data_window,wave_type); %小波特征
    features{i} = feature;
    i = i +1;

end
cpu_time = toc
save features.mat features
% load features.mat features

% 训练并计算正确率
% classfier为训练模型，validationAccuracy为50%训练50%测试的交叉验证正确率
[classfier,validationAccuracy] = SVMclassfier(features);
fprintf('The accuracy is: %f. \n',validationAccuracy)

