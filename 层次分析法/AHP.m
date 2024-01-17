%% 使用python直接对浮点数进行加减会有误差，
%  而matlab直接进行浮点数加减则不会，
%  故提供以下matlab代码，可分节运行
%% 输入判断矩阵，或导入文件
clear;clc
% A = input('判断矩阵A=')
% [A,Text] = xlsread('文件路径/文件名.xlsx')
A =[1 1 4 1/3 3;
 1 1 4 1/3 3;
 1/4 1/4 1 1/3 1/2;
 3 3 3 1 3;
 1/3 1/3 2 1/3 1]
%% 首先进行一致性检验
n = size(A,1)
[V,D] = eig(A)
Max_eig = max(max(D))
CI = (Max_eig - n) / (n-1);
RI = [0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  
CR = CI/RI(n);
disp('一致性指标CI=');disp(CI);
disp('一致性比例CR=');disp(CR);
if CR<0.10
    disp('CR < 0.10，一致性可以接受!');
else
    disp('CR >= 0.10，该判断矩阵需要进行修改!');
end
%% 方法1：算术平均法求权重
Sum_A = sum(A)
[n,n] = size(A)  
SUM_A = repmat(Sum_A,n,1)  
Stand_A = A ./ SUM_A
sum(Stand_A,2)
arith_weight = sum(Stand_A,2) / n
disp('算术平均法求权重的结果为：');
disp(arith_weight)

%% 方法2：几何平均法求权重
Prduct_A = prod(A,2)
Prduct_n_A = Prduct_A .^ (1/n)
geo_weight = Prduct_n_A ./ sum(Prduct_n_A)
disp('几何平均法求权重的结果为：');
disp(geo_weight)

%% 方法3：特征值法求权重
[r,c] = find(D == Max_eig , 1)
V(:,c)
fea_weight = V(:,c) ./ sum(V(:,c)) 
disp('特征值法求权重的结果为：');
disp( fea_weight )
