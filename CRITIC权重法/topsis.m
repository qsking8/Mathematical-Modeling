%%  以下为在之前TOPSIS代码的基础上，由CRITIC法确定权重，再结合权重确定得分的代码，可分节运行
clear;clc
load data_water_quality.mat

%%  第一步：对判断矩阵进行正向化
[n,m] = size(X);
disp(['共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标']) 
%指标二为中间型，越接近7越好
best = 7
A = X(:,2)
M = max(abs(A-best))
A = 1 - abs(A-best) / M
X(:,2) = A
%指标三为极小型，越小越好
B = X(:,3)
N = max(B)
B = N - B
X(:,3) = B
%指标四为区间型，介于10-20之间最好
a = 10
b = 20
C = X(:,4)
row = size(C,1)
P = max([a-min(C),max(C)-b])
for i = 1: row
        if C(i) < a
           C(i) = 1-(a-C(i))/P;
        elseif C(i) > b
           C(i) = 1-(C(i)-b)/P;
        else
           C(i) = 1;
        end
end
X(:,4) = C

%% 第二步：对正向化后的矩阵进行标准化
Z = zeros(n,m)
for i = 1:m
    Z(:, i) = (X(:, i) - min(X(:, i)))/(max(X(:, i)) - min(X(:, i)));
end
disp(Z)
%% 第三步：确定权重
data = Z
corr = corrcoef(data);  % 计算相关系数矩阵
corr_1 = sum(1 - corr); % 计算冲突性
data_std = std(data); % 计算每列标准差
C = data_std .* corr_1; % 计算信息量
weight = C./sum(C); % 计算权重
disp('CRITIC法确定的权重为：')
disp(weight) 
  
%% 第四步：计算出得分
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;  
S = D_N ./ (D_P+D_N);    % 未归一化的得分
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')
disp('最后的得分为：')
disp(stand_S)
