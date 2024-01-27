% 读取Excel文件
filename = 'C:\Users\65349\Desktop\Mathematical-Modeling\Mathematical-Modeling\空间相关性-莫兰指数\实战\31省经纬度.xlsx';
data = readtable(filename, 'Sheet', 'Sheet1');

% 获取x和y列的数据
x = data(:, 3).Variables;
y = data(:, 4).Variables;
% 构建B矩阵
B = [x y];
for i = 1:31
    for j=1:31
        C(i,j)=sqrt((B(i,1)-B(j,1))^2+(B(i,2)-B(j,2))^2);
    end
end
D = (C*pi)/180*6378.2; %将°换算成KM
E = 1./D;
E(E==inf)=0;
E2=sum(E,2);%按行求和
E3=diag(E2);%生成对角阵
J=(E3)^(-1/2);
W=J*E*J;
% 将矩阵W保存为Excel文件
output_filename = 'mapweight.xlsx';
writematrix(W, output_filename);
disp(['Matrix W has been saved to ' output_filename]);