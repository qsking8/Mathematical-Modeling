%% ��ɫ�������������ۺ����۵Ĵ��룬�ɷֽ�����
clear;clc
load data_water_quality.mat

%%  ָ������
[n,m] = size(X);
disp(['����' num2str(n) '�����۶���, ' num2str(m) '������ָ��']) 
%ָ���Ϊ�м��ͣ�Խ�ӽ�7Խ��
best = 7;
A = X(:,2);
M = max(abs(A-best));
A = 1 - abs(A-best) / M;
X(:,2) = A;
%ָ����Ϊ��С�ͣ�ԽСԽ��
B = X(:,3);
N = max(B);
B = N - B;
X(:,3) = B;
%ָ����Ϊ�����ͣ�����10-20֮�����
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
disp('���򻯺�ľ���Ϊ��')
disp(X)
%% �����򻯺�ľ������Ԥ����
Mean = mean(X);  % ���ÿһ�еľ�ֵ�Թ�����������Ԥ����
row = size(X,1);
pro = repmat(Mean,row,1);
Z = X ./ pro;  
disp('Ԥ�����ľ���Ϊ��'); disp(Z)

%% ����ĸ���к�������
Y = max(Z,[],2);  % ĸ����Ϊ����ģ���ÿһ�е����ֵ���ɵ���������ʾĸ����
X = Z; % �����о���Ԥ���������ݾ���

%% ����÷�
absX0_Xi = abs(X - repmat(Y,1,size(X,2)))  % ����|X0-Xi|����
a = min(min(absX0_Xi))    % ����������С��a
b = max(max(absX0_Xi))  % ������������b
rho = 0.5; % �ֱ�ϵ��ȡ0.5
gamma = (a+rho*b) ./ (absX0_Xi  + rho*b)  % �����������и���ָ����ĸ���еĹ���ϵ��
weight = mean(gamma) / sum(mean(gamma));  % �����������и���ָ��Ļ�ɫ�����ȼ���Ȩ��
score = sum(X .* repmat(weight,size(X,1),1),2);   % δ��һ���ĵ÷�
stand_S = score / sum(score);   % ��һ����ĵ÷�
[sorted_S,index] = sort(stand_S ,'descend') % ��������
disp('�����õĵ÷�Ϊ��')
disp(stand_S)