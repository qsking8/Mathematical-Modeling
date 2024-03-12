function dx=SIR_fun(t,x,beta1,beta2,a,b)  
    % beta1 : t<=15ʱ���׸�Ⱦ�����Ѹ�Ⱦ�߽Ӵ��ұ���Ⱦ��ǿ��
    % beta2   : t>15ʱ���׸�Ⱦ�����Ѹ�Ⱦ�߽Ӵ��ұ���Ⱦ��ǿ��
    % a  : ������gamma = a+bt
    % b  : ������gamma = a+bt
    if t <=15
        beta = beta1;
    else
        beta = beta2;
    end
    gamma = a + b * t;  
    dx = zeros(3,1);  % x(1)��ʾS  x(2)��ʾI  x(3)��ʾR
    C = x(1)+x(2);  % ��Ⱦ��ϵͳ�е���Ч��Ⱥ,Ҳ���ǿμ��е�N' = S+I
    dx(1) = - beta*x(1)*x(2)/C;  
    dx(2) = beta*x(1)*x(2)/C - gamma*x(2);
    dx(3) = gamma*x(2); 
end
