function y = Obj_fun3(x)
    y = 21.5 + x(1)*sin(4*pi*x(1)) + x(2)*sin(20*pi*x(2));
      %   y = -(21.5 + x(1)*sin(4*pi*x(1)) + x(2)*sin(20*pi*x(2)));  % 使用优化工具箱
end