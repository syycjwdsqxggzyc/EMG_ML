function [ result ] = motionpredict( f,B )
    %motionpredict 动作预测
    %   f为分类器函数，B为输入特征值矩阵，result为输出结果（数字）表示
    [response2,prediect2]=MyReshape(B);
    prediect2(isnan(prediect2)) = 0;
    result=f(prediect2);
end

