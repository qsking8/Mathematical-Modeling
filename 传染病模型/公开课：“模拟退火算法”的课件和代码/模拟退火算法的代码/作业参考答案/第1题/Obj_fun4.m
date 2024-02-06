function y = Obj_fun4(x)
% 使用优化工具箱是求最小值的，因此要给目标函数添加负号
     y = -(21.5 + x(1)*sin(4*pi*x(1)) + x(2)*sin(20*pi*x(2)));  
end