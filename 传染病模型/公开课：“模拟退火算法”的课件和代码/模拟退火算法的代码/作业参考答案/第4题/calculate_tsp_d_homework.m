function  result =  calculate_tsp_d_homework(path,d)
% ���룺path:·����1��n��һ�����У���d���������
    n = length(path);
    result = 0; % ��ʼ����·���ߵľ���Ϊ0
    for i = 1:n-1 
        result = d(path(i),path(i+1)) + result;  % ����������в��ϵĸ����߹���·�����ֵ
    end   
end