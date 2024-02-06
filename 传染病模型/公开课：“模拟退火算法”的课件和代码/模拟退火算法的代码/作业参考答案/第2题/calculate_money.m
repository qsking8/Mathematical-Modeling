function  money =  calculate_money(way,freight,M,s,b)
% 输入：way: 购买方案； fright:运费;  M: 每本书在每家店的价格;  s:一个有几家店； b：一共要购买几本书
    money_store = zeros(s,1);  % 保存每家店购买书的费用（只含书价，不含运费）
    for i = 1:b  % 依次循环每本书
        which_store = way(i);  % 找到第i本书在哪家店买的
        money_store(which_store) = money_store(which_store) + M(which_store, i);  % 更新在这个书店买书的费用
    end
    index = unique(way);  % 在哪些商店购买了商品，因为我们等下要计算运费
    no_freight_index = find(money_store >= 88);  % 找到可以包邮的店铺，即买书费用高于88元的店铺
    fin_index = setdiff(index, no_freight_index);  % 求两个集合的差集，最终保留下来的元素就是要需要支付运费的书店
    money = sum(money_store) + sum(freight(fin_index));  % 计算最终的总花费：购买书的费用 + 运费
end 