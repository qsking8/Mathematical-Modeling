%% 灰色关联分析用于综合评价的代码，可分节运行
clear;clc
load data_water_quality.mat

%%  指标正向化
[n,m] = size(X);
disp(['共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标']) 
%指标二为中间型，越接近7越好
best = 7;
A = X(:,2);
M = max(abs(A-best));
A = 1 - abs(A-best) / M;
X(:,2) = A;
%指标三为极小型，越小越好
B = X(:,3);
N = max(B);
B = N - B;
X(:,3) = B;
%指标四为区间型，介于10-20之间最好
a = 10;
b = 20;
C = X(:,4);
row = size(C,1);
P = max([a-min(C),max(C)-b]);
for i = 1: row
        if C(i) < a
           C(i) = 1-(a-C(i))/P;
        elseif C(i) > b
           C(i) = 1-(C(i)-b)/P;
        else
           C(i) = 1;
        end
end
X(:,4) = C;
disp('正向化后的矩阵为：')
disp(X)
%% 对正向化后的矩阵进行预处理
Mean = mean(X);  % 求出每一列的均值以供后续的数据预处理
row = size(X,1);
pro = repmat(Mean,row,1);
Z = X ./ pro;  
disp('预处理后的矩阵为：'); disp(Z)

%% 构造母序列和子序列
Y = max(Z,[],2);  % 母序列为虚拟的，用每一行的最大值构成的列向量表示母序列
X = Z; % 子序列就是预处理后的数据矩阵

%% 计算得分
absX0_Xi = abs(X - repmat(Y,1,size(X,2)))  % 计算|X0-Xi|矩阵
a = min(min(absX0_Xi))    % 计算两级最小差a
b = max(max(absX0_Xi))  % 计算两级最大差b
rho = 0.5; % 分辨系数取0.5
gamma = (a+rho*b) ./ (absX0_Xi  + rho*b)  % 计算子序列中各个指标与母序列的关联系数
weight = mean(gamma) / sum(mean(gamma));  % 利用子序列中各个指标的灰色关联度计算权重
score = sum(X .* repmat(weight,size(X,1),1),2);   % 未归一化的得分
stand_S = score / sum(score);   % 归一化后的得分
[sorted_S,index] = sort(stand_S ,'descend') % 进行排序
disp('最后求得的得分为：')
disp(stand_S)