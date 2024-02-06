function  money =  calculate_money(way,freight,M,b)
% 输入：way: 购买方案； fright:运费;  M: 每本书在每家店的价格; b：一共要购买几本书
   index = unique(way);  % 在哪些商店购买了商品，因为我们等下要计算运费
   money = sum(freight(index)); % 计算买书花费的运费
    % 计算总花费：刚刚计算出来的运费 + 五本书的售价
    for i = 1:b 
        money = money + M(way(i),i);  
    end
end