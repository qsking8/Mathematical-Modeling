%% ʹ��pythonֱ�ӶԸ��������мӼ�������
%  ��matlabֱ�ӽ��и������Ӽ��򲻻ᣬ
%  ���ṩ����matlab���룬�ɷֽ�����
%% �����жϾ��󣬻����ļ�
clear;clc
% A = input('�жϾ���A=')
% [A,Text] = xlsread('�ļ�·��/�ļ���.xlsx')
A =[1 1 4 1/3 3;
 1 1 4 1/3 3;
 1/4 1/4 1 1/3 1/2;
 3 3 3 1 3;
 1/3 1/3 2 1/3 1]
%% ���Ƚ���һ���Լ���
n = size(A,1)
[V,D] = eig(A)
Max_eig = max(max(D))
CI = (Max_eig - n) / (n-1);
RI = [0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  
CR = CI/RI(n);
disp('һ����ָ��CI=');disp(CI);
disp('һ���Ա���CR=');disp(CR);
if CR<0.10
    disp('CR < 0.10��һ���Կ��Խ���!');
else
    disp('CR >= 0.10�����жϾ�����Ҫ�����޸�!');
end
%% ����1������ƽ������Ȩ��
Sum_A = sum(A)
[n,n] = size(A)  
SUM_A = repmat(Sum_A,n,1)  
Stand_A = A ./ SUM_A
sum(Stand_A,2)
arith_weight = sum(Stand_A,2) / n
disp('����ƽ������Ȩ�صĽ��Ϊ��');
disp(arith_weight)

%% ����2������ƽ������Ȩ��
Prduct_A = prod(A,2)
Prduct_n_A = Prduct_A .^ (1/n)
geo_weight = Prduct_n_A ./ sum(Prduct_n_A)
disp('����ƽ������Ȩ�صĽ��Ϊ��');
disp(geo_weight)

%% ����3������ֵ����Ȩ��
[r,c] = find(D == Max_eig , 1)
V(:,c)
fea_weight = V(:,c) ./ sum(V(:,c)) 
disp('����ֵ����Ȩ�صĽ��Ϊ��');
disp( fea_weight )
