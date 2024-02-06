function path1 = gen_new_path(path0)
    % path0: 原来的路径
    n = length(path0);
    % 随机选择两种产生新路径的方法
    p1 = 0.33;  % 使用交换法产生新路径的概率
    p2 = 0.33;  % 使用移位法产生新路径的概率
    r = rand(1); % 随机生成一个[0 1]间均匀分布的随机数
    if  r< p1    % 使用交换法产生新路径 
        c1 = randi(n);   % 生成1-n中的一个随机整数
        c2 = randi(n);   % 生成1-n中的一个随机整数
        path1 = path0;  % 将path0的值赋给path1
        path1(c1) = path0(c2);  %改变path1第c1个位置的元素为path0第c2个位置的元素
        path1(c2) = path0(c1);  %改变path1第c2个位置的元素为path0第c1个位置的元素
    elseif r < p1+p2 % 使用移位法产生新路径
        c1 = randi(n);   % 生成1-n中的一个随机整数
        c2 = randi(n);   % 生成1-n中的一个随机整数
        c3 = randi(n);   % 生成1-n中的一个随机整数
        sort_c = sort([c1 c2 c3]);  % 对c1 c2 c3从小到大排序
        c1 = sort_c(1);  c2 = sort_c(2);  c3 = sort_c(3);  % c1 < = c2 <=  c3
        tem1 = path0(1:c1-1);
        tem2 = path0(c1:c2);
        tem3 = path0(c2+1:c3);
        tem4 = path0(c3+1:end);
        path1 = [tem1 tem3 tem2 tem4];
    else  % 使用倒置法产生新路径
        c1 = randi(n);   % 生成1-n中的一个随机整数
        c2 = randi(n);   % 生成1-n中的一个随机整数
        if c1>c2  % 如果c1比c2大，就交换c1和c2的值
            tem = c2;
            c2 = c1;
            c1 = tem;
        end
        tem1 = path0(1:c1-1);
        tem2 = path0(c1:c2);
        tem3 = path0(c2+1:end);
        path1 = [tem1 fliplr(tem2) tem3];   %矩阵的左右对称翻转 fliplr，上下对称翻转 flipud
    end
end