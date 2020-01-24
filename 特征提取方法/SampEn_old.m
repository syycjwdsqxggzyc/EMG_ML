
function SampEnVal = SampEn_old(data, m, r)
%SAMPEN  计算时间序列data的样本熵
%        data为输入数据序列
%        m为初始分段，每段的数据长度
%        r为阈值
% $Author: lskyp
% $Date:   2010.6.20

data = data(:)';
N = length(data);

% 分段计算距离
for k = N - m:-1:1
    xm(k, :) = data(k:k + m - 1);
end
for k = N - m:-1:1
    for p = N - m:-1:1
        % 统计距离，k=p时距离为0，计算时舍去一个即可
        d(k, p) = max(abs(xm(p, :) - xm(k, :)));
    end
end

% 模板匹配数以及平均值计算
Nk = 0;
for k = N - m:-1:1
    Nk = Nk + (sum(d(k, :) < r) - 1)/(N - m - 1);
end
Bm = Nk/(N - m);

clear xm d Nk

% m值增加1，重复上面的计算
m = m + 1;
% 分段计算距离
for k = N - m:-1:1
    xm(k, :) = data(k:k + m - 1);
end
for k = N - m:-1:1
    for p = N - m:-1:1
        % 统计距离，k=p时距离为0，计算时舍去一个即可
        d(k, p) = max(abs(xm(p, :) - xm(k, :)));
    end
end

% 模板匹配数以及平均值计算
Nk = 0;
for k = N - m:-1:1
    Nk = Nk + (sum(d(k, :) < r) - 1)/(N - m - 1);
end
Bmadd1 = Nk/(N - m);

% 熵值
SampEnVal = -log(Bmadd1/Bm);
