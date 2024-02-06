% function way1 = gen_new_way(way0, s, b)
% % way0��ԭ�������鷽������һ��1*b��������ÿһ��Ԫ�ض�λ��1-s֮��
%         index =  randi([1, b],1) ;  % ����һ����Ҫ������깺��
%         way1 = way0;  % ��ԭ���ķ�����ֵ��way1
%         way1(index) = randi([1, s],1);  % ��way1�еĵ�index���黻һ����깺��   
% end
function way1 = gen_new_way(way0, s, b)
% way0��ԭ�������鷽������һ��1*b��������ÿһ��Ԫ�ض�λ��1-s֮��
        index =  randi([1, b],1) ;  % ����һ����Ҫ������깺��
        way1 = way0;  % ��ԭ���ķ�����ֵ��way1
        r = rand(1);  % ����һ�������
        if r < 0.5   
            way1(index) = randi([1, s],1);  % ��way1�еĵ�index���黻һ����깺��   
        else % ���Ѿ������ĵ�������������� 
            tem = unique(way0);  
            n = length(tem);
            ind = randi([1, n],1);
            way1(index) = tem(ind);
end
