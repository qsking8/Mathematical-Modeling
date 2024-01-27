% ��ȡExcel�ļ�
filename = 'C:\Users\65349\Desktop\Mathematical-Modeling\Mathematical-Modeling\�ռ������-Ī��ָ��\ʵս\31ʡ��γ��.xlsx';
data = readtable(filename, 'Sheet', 'Sheet1');

% ��ȡx��y�е�����
x = data(:, 3).Variables;
y = data(:, 4).Variables;
% ����B����
B = [x y];
for i = 1:31
    for j=1:31
        C(i,j)=sqrt((B(i,1)-B(j,1))^2+(B(i,2)-B(j,2))^2);
    end
end
D = (C*pi)/180*6378.2; %���㻻���KM
E = 1./D;
E(E==inf)=0;
E2=sum(E,2);%�������
E3=diag(E2);%���ɶԽ���
J=(E3)^(-1/2);
W=J*E*J;
% ������W����ΪExcel�ļ�
output_filename = 'mapweight.xlsx';
writematrix(W, output_filename);
disp(['Matrix W has been saved to ' output_filename]);