function [way1, delta_weight] = gen_new_way(way0, n, weight)
% way0��ԭ����װ�ط�����  n����Ʒ����  ; weight����Ʒ������
% way1���µ�װ�ط����� delta_weight�������ı仯��
       i = randi([1,n],1);  % ���ѡȡһ����Ʒi
       if way0(i) == 1  % �����Ʒi��ԭ���ı�����
           way0(i) = 0;  % �ӱ�����ȡ����Ʒi
           empty_ind = find(way0==0); % �����������ļ���λ���ǿյ�
           length_empth_ind = length(empty_ind);  % �����λ�õĸ���
           ind = randi([1, length_empth_ind], 1); % ���⼸����λ����ȡһ������±� 
           j = empty_ind(ind);  % j�������ѡ������ı����е�ĳ����λ��
           way0(j) = 1;  % װ����Ʒj
           delta_weight = weight(j) - weight(i);  % ���������ı仯��
       else  % �����Ʒiԭ���Ͳ��ڱ�����
           way0(i) = 1; % �ڱ����з�����Ʒi
           delta_weight = weight(i);  % ���������ı仯��
           if rand(1) < 0.5 % �ж��Ƿ���Ҫ��ȡ��һ����Ʒ�������0.5����Ҫ��ȡ����Ʒ�ĸ��ʣ������Լ�������
               fill_ind = find(way0==1); % �����������ļ���λ������Ʒ
               length_fill_ind = length(fill_ind);  % ��������Ʒ��λ�õĸ���
               ind = randi([1, length_fill_ind], 1); % ���⼸������Ʒ��λ����ȡһ������±� 
               j = fill_ind(ind);  % j�������ѡ������ı����е�ĳ������Ʒ��λ��
               way0(j) = 0;  % ȡ����Ʒj
               delta_weight = weight(i) - weight(j);  % ���������ı仯��
           end
       end
       way1 = way0;  % ���������way0��ֵ��way1
end
