 %% ��ɫ������������ϵͳ�����Ĵ���
clear;clc
load gdp.mat  % ��������
Mean = mean(gdp);  % ���ÿһ�еľ�ֵ�Թ�����������Ԥ����
row = size(gdp,1);
pro = repmat(Mean,row,1);
gdp = gdp ./ pro; 
disp('Ԥ�����ľ���Ϊ��'); disp(gdp)
Y = gdp(:,1);  % ĸ����
X = gdp(:,2:end); % ������
col = size(X,2);
pro_y = repmat(Y,1,size(X,2));
absX0_Xi = abs(X - pro_y)  % ����|X0-Xi|����(���������ǰ�X0����Ϊ��Y)
a = min(min(absX0_Xi))    % ����������С��a
b = max(max(absX0_Xi))  % ������������b 0.5084    0.6243    0.7573
rho = 0.5; % �ֱ�ϵ��ȡ0.5
gamma = (a+rho*b) ./ (absX0_Xi  + rho*b)  % �����������и���ָ����ĸ���еĹ���ϵ��
disp('�������и���ָ��Ļ�ɫ�����ȷֱ�Ϊ��')
disp(mean(gamma))