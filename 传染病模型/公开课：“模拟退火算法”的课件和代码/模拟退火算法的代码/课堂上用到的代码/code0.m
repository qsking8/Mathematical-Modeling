%% ���ƽ����½����p���¶�T�仯��ͼ
T = 0.1:0.1:100;  % �¶�
% ����������ͬ�ĺ����仯ֵ
delta_f1 = 0.1; 
delta_f2 = 1;
delta_f3 = 10;
% �ֱ����������ͬ�ĺ����仯ֵ�½����½�ĸ���
p1 = exp(-delta_f1 ./ T);
p2 = exp(-delta_f2 ./ T);
p3 = exp(-delta_f3 ./ T);
plot(T, p1, T, p2, T, p3 , 'LineWidth' , 2)
xlabel('�¶�T'); ylabel('�����½�ĸ���p')
legend('delta f = 0.1','delta f = 1','delta f= 10')
