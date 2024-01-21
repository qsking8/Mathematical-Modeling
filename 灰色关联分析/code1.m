 %% 灰色关联分析用于系统分析的代码
clear;clc
load gdp.mat  % 导入数据
Mean = mean(gdp);  % 求出每一列的均值以供后续的数据预处理
row = size(gdp,1);
pro = repmat(Mean,row,1);
gdp = gdp ./ pro; 
disp('预处理后的矩阵为：'); disp(gdp)
Y = gdp(:,1);  % 母序列
X = gdp(:,2:end); % 子序列
col = size(X,2);
pro_y = repmat(Y,1,size(X,2));
absX0_Xi = abs(X - pro_y)  % 计算|X0-Xi|矩阵(在这里我们把X0定义为了Y)
a = min(min(absX0_Xi))    % 计算两级最小差a
b = max(max(absX0_Xi))  % 计算两级最大差b 0.5084    0.6243    0.7573
rho = 0.5; % 分辨系数取0.5
gamma = (a+rho*b) ./ (absX0_Xi  + rho*b)  % 计算子序列中各个指标与母序列的关联系数
disp('子序列中各个指标的灰色关联度分别为：')
disp(mean(gamma))