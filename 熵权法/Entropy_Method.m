function [W] = Entropy_Method(Z)
%% ������Ȩ
    [n,m] = size(Z);
    D = zeros(1,m);  
    for i = 1:m
        x = Z(:,i);  
        p = x / sum(x);%�������
        e = -sum(p .* mylog(p)) / log(n); %���Լ������log����������Ϣ��
        D(i) = 1 - e; % ������ϢЧ��ֵ
    end
    W = D ./ sum(D);  % ����ϢЧ��ֵ��һ�����õ�Ȩ��
end
