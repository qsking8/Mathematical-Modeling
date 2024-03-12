function  money =  calculate_money(way,freight,M,s,b)
% ���룺way: ���򷽰��� fright:�˷�;  M: ÿ������ÿ�ҵ�ļ۸�;  s:һ���м��ҵꣻ b��һ��Ҫ���򼸱���
    money_store = zeros(s,1);  % ����ÿ�ҵ깺����ķ��ã�ֻ����ۣ������˷ѣ�
    for i = 1:b  % ����ѭ��ÿ����
        which_store = way(i);  % �ҵ���i�������ļҵ����
        money_store(which_store) = money_store(which_store) + M(which_store, i);  % ����������������ķ���
    end
    index = unique(way);  % ����Щ�̵깺������Ʒ����Ϊ���ǵ���Ҫ�����˷�
    no_freight_index = find(money_store >= 88);  % �ҵ����԰��ʵĵ��̣���������ø���88Ԫ�ĵ���
    fin_index = setdiff(index, no_freight_index);  % ���������ϵĲ�����ձ���������Ԫ�ؾ���Ҫ��Ҫ֧���˷ѵ����
    money = sum(money_store) + sum(freight(fin_index));  % �������յ��ܻ��ѣ�������ķ��� + �˷�
end 