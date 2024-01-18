function [W] = Entropy_Method(Z)
%% 计算熵权
    [n,m] = size(Z);
    D = zeros(1,m);  
    for i = 1:m
        x = Z(:,i);  
        p = x / sum(x);%计算概率
        e = -sum(p .* mylog(p)) / log(n); %用自己定义的log函数计算信息熵
        D(i) = 1 - e; % 计算信息效用值
    end
    W = D ./ sum(D);  % 将信息效用值归一化，得到权重
end
