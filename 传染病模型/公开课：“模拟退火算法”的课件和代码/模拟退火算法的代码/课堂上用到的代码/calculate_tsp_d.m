function  result =  calculate_tsp_d(path,d)
% 输入：path:路径（1至n的一个序列），d：距离矩阵
    n = length(path);
    result = 0; % 初始化该路径走的距离为0
    for i = 1:n-1  
        result = d(path(i),path(i+1)) + result;  % 按照这个序列不断的更新走过的路程这个值
    end   
    result = d(path(1),path(n)) + result;  % 别忘了加上从最后一个城市返回到最开始那个城市的距离
end