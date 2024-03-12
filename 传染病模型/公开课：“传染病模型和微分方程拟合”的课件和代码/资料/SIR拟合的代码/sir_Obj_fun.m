function f = sir_Obj_fun(x)
    global true_s true_i true_r;  % 在子函数中使用全局变量前也需要声明下
    beta = x(1);
    gamma = x(2);
    [~,p]=ode45(@(t,p) sir_fun(t,p,beta,gamma), [1:1:30],[true_s(1) true_i(1) true_r(1)]); 
    f = sum((true_s - p(:,1)).^2  + (true_i -  p(:,2)).^2  + (true_r - p(:,3)).^2);
end