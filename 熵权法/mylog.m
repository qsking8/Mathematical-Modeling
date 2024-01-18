% 重新定义一个mylog函数，当输入的p中元素为0时，返回0
function [lnp] =  mylog(p)
n = length(p);  
lnp = zeros(n,1);  
    for i = 1:n   
        if p(i) == 0   % 如果第i个元素为0
            lnp(i) = 0;  % 那么返回的第i个结果也为0
        else
            lnp(i) = log(p(i));  
        end
    end
end