function [ result ] = motionpredict( f,B )
    %motionpredict ����Ԥ��
    %   fΪ������������BΪ��������ֵ����resultΪ�����������֣���ʾ
    [response2,prediect2]=MyReshape(B);
    prediect2(isnan(prediect2)) = 0;
    result=f(prediect2);
end

