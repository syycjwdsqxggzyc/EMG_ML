
function SampEnVal = SampEn_old(data, m, r)
%SAMPEN  ����ʱ������data��������
%        dataΪ������������
%        mΪ��ʼ�ֶΣ�ÿ�ε����ݳ���
%        rΪ��ֵ
% $Author: lskyp
% $Date:   2010.6.20

data = data(:)';
N = length(data);

% �ֶμ������
for k = N - m:-1:1
    xm(k, :) = data(k:k + m - 1);
end
for k = N - m:-1:1
    for p = N - m:-1:1
        % ͳ�ƾ��룬k=pʱ����Ϊ0������ʱ��ȥһ������
        d(k, p) = max(abs(xm(p, :) - xm(k, :)));
    end
end

% ģ��ƥ�����Լ�ƽ��ֵ����
Nk = 0;
for k = N - m:-1:1
    Nk = Nk + (sum(d(k, :) < r) - 1)/(N - m - 1);
end
Bm = Nk/(N - m);

clear xm d Nk

% mֵ����1���ظ�����ļ���
m = m + 1;
% �ֶμ������
for k = N - m:-1:1
    xm(k, :) = data(k:k + m - 1);
end
for k = N - m:-1:1
    for p = N - m:-1:1
        % ͳ�ƾ��룬k=pʱ����Ϊ0������ʱ��ȥһ������
        d(k, p) = max(abs(xm(p, :) - xm(k, :)));
    end
end

% ģ��ƥ�����Լ�ƽ��ֵ����
Nk = 0;
for k = N - m:-1:1
    Nk = Nk + (sum(d(k, :) < r) - 1)/(N - m - 1);
end
Bmadd1 = Nk/(N - m);

% ��ֵ
SampEnVal = -log(Bmadd1/Bm);
