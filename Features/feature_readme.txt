
若使用FFT+时域提取信号特征：
1、若data_sample: XXX*16，调用find_features.m，返回 37*16特征向量；
2、若data_sample: XXX*16*n，调用find_features_total.m，返回 37*16*n特征向量；

若使用小波分解提取信号特征：
1、若data_sample: XXX*16，调用wavelet_feature.m，返回 18*16特征向量；
2、若data_sample: XXX*16*n，调用wavelet_feature_total.m，返回 18*16*n特征向量；

数据分窗：
sample_sliding_window.m，用于数据分窗。

