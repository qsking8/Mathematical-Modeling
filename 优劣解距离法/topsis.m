%%  ����ΪTOPSIS����������Ȩ�أ���matlabʵ�ִ��룬�ɷֽ�����
clear;clc
load data_water_quality.mat

%%  ��һ�������жϾ����������
[n,m] = size(X);
disp(['����' num2str(n) '�����۶���, ' num2str(m) '������ָ��'])
%ָ���Ϊ�м��ͣ�Խ�ӽ�7Խ��
best = 7
A = X(:,2)
M = max(abs(A-best))
A = 1 - abs(A-best) / M
X(:,2) = A
%ָ����Ϊ��С�ͣ�ԽСԽ��
B = X(:,3)
N = max(B)
B = N - B
X(:,3) = B
%ָ����Ϊ�����ͣ�����10-20֮�����
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
%% �ڶ��������򻯾�����б�׼��
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('��׼������ Z = ')
disp(Z)

%% ��������������÷�
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ],2) .^ 0.5;   
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ],2) .^ 0.5;   
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')
disp('���ĵ÷�Ϊ��')
disp(stand_S)
disp(sum(stand_S))

