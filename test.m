% 
clc;
clear;
close all;
tic

addpath('./Features')
addpath('./SVM')
% ����
file_dir = '.\right\';
window_width = 128; % ������һ��Ϊ2�������ݣ�����Ĭ��Ϊ����һ��
wave_type = 'db1'; % С������

% �о��ļ��������е��ļ�
file_folder=fullfile(file_dir);
dirOutput=dir(fullfile(file_folder,'*.txt'));
file_names = {dirOutput.name};%file_names���������txt�ļ�ȫ��


%%
% ��ȡ����������featuresԪ��
% featuresΪһ��Ԫ�飬����8��Ԫ�أ�ÿ��Ԫ�ض�Ӧһ��������ÿ�������洢����18*16������ֵ
% features��8��Ԫ�����ζ�Ӧ: eight,finger,fist,good,inner,ok,openpalm,outer,relax
i = 1;
for file_name = file_names%��ֵ
    %��ȡ����
    file_path = strcat(file_dir,file_name{1});%strcat�ַ���ƴ�ӵõ�����·��
    data_with_time = load(file_path);
    data = data_with_time(:,1:16); % ɾ��ʱ���
    %������Ϊֹ���Ѿ��õ���16ͨ��������
    
    % ���Լ��ķִ������������ݷִ�
    data_window = sample_sliding_window(data,window_width);
    %data��10000*16��С�������ִ�������64���󷵻�128*16*156��156Ϊ����Ϊ����������
    
    % ��ȡ����ֵ����ѡ��ʱ��������С������
    % ʱ����������ʱ��ϳ��������ĵȴ�
     feature = find_features_total(data_window); %ʱƵ����
    %feature = wavelet_feature_total(data_window,wave_type); %С������
    features{i} = feature;
    i = i +1;

end
cpu_time = toc
save features.mat features
% load features.mat features

% ѵ����������ȷ��
% classfierΪѵ��ģ�ͣ�validationAccuracyΪ50%ѵ��50%���ԵĽ�����֤��ȷ��
[classfier,validationAccuracy] = SVMclassfier(features);
fprintf('The accuracy is: %f. \n',validationAccuracy)

