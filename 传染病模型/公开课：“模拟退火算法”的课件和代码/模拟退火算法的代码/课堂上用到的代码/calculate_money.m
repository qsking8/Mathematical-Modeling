function  money =  calculate_money(way,freight,M,b)
% ���룺way: ���򷽰��� fright:�˷�;  M: ÿ������ÿ�ҵ�ļ۸�; b��һ��Ҫ���򼸱���
   index = unique(way);  % ����Щ�̵깺������Ʒ����Ϊ���ǵ���Ҫ�����˷�
   money = sum(freight(index)); % �������黨�ѵ��˷�
    % �����ܻ��ѣ��ոռ���������˷� + �屾����ۼ�
    for i = 1:b 
        money = money + M(way(i),i);  
    end
end