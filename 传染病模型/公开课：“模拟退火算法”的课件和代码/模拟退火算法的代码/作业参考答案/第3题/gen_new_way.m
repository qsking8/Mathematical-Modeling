function [way1, delta_weight] = gen_new_way(way0, n, weight)
% way0：原来的装载方案；  n是物品个数  ; weight是物品的重量
% way1：新的装载方案； delta_weight：重量的变化量
       i = randi([1,n],1);  % 随机选取一个物品i
       if way0(i) == 1  % 如果物品i在原来的背包中
           way0(i) = 0;  % 从背包里取出物品i
           empty_ind = find(way0==0); % 看看背包中哪几个位置是空的
           length_empth_ind = length(empty_ind);  % 计算空位置的个数
           ind = randi([1, length_empth_ind], 1); % 在这几个空位置中取一个随机下标 
           j = empty_ind(ind);  % j就是随机选择出来的背包中的某个空位置
           way0(j) = 1;  % 装入物品j
           delta_weight = weight(j) - weight(i);  % 计算重量的变化量
       else  % 如果物品i原来就不在背包中
           way0(i) = 1; % 在背包中放入物品i
           delta_weight = weight(i);  % 计算重量的变化量
           if rand(1) < 0.5 % 判断是否需要再取出一个物品（这里的0.5是需要再取出物品的概率，可以自己调整）
               fill_ind = find(way0==1); % 看看背包中哪几个位置有物品
               length_fill_ind = length(fill_ind);  % 计算有物品的位置的个数
               ind = randi([1, length_fill_ind], 1); % 在这几个有物品的位置中取一个随机下标 
               j = fill_ind(ind);  % j就是随机选择出来的背包中的某个有物品的位置
               way0(j) = 0;  % 取出物品j
               delta_weight = weight(i) - weight(j);  % 计算重量的变化量
           end
       end
       way1 = way0;  % 将调整后的way0赋值给way1
end
