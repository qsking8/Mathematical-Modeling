function way1 = gen_new_way(way0, s, b)
% way0��ԭ�������鷽������һ��1*b��������ÿһ��Ԫ�ض�λ��1-s֮��
        index =  randi([1, b],1) ;  % ����һ����Ҫ������깺��
        way1 = way0;  % ��ԭ���ķ�����ֵ��way1
        way1(index) = randi([1, s],1);  % ��way1�еĵ�index���黻һ����깺��   
end
