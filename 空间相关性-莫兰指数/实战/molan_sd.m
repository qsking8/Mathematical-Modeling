% 读取Excel文件
filename = 'C:\Users\65349\Desktop\Mathematical-Modeling\Mathematical-Modeling\空间相关性-莫兰指数\实战\31省数据.xlsx';
data = readtable(filename, 'Sheet', '各个指标数据2022');
W = readmatrix(filename, 'Sheet', '空间权重矩阵');
name=data(:, 1).Variables;

% 获取所有列名
column_names = data.Properties.VariableNames;

% 循环处理第5列到第14列的数据
for i = 5:14
    % 获取y列的数据
    y = data(:, i).Variables;
    output_filename = sprintf('%s.txt', column_names{i});
    title_str = sprintf('%s 莫兰指数', column_names{i});
    
    yd=y-mean(y);
    m=length(y(:));
    p=(max(yd)*10)/10 + 0.005;
    p2=((-10)*min(yd))/(-10)- 0.005;
    W=normw(W);
    W2=W*yd;
    p3=(max(W2)*10)/10 + 0.005;
    p4=((-10)*min(W2))/(-10)- 0.005;
    a=[p2,p];%x
    b=[p4,p3];%y轴
    
    figure('visible', 'off');
    scatter(yd,W2,'ro');
    grid on 
    axis([a, b]);  % 设置坐标轴范围
    % 生成输出文件名和标题
    xlabel('yd'),ylabel('W2'),title(title_str);
    hold on;
    x=a;y=[0,0];
    plot(x,y);
    x=[0,0];y=b;
    plot(x,y);
    lsline

    id=name';
    for j =(1:m)
        text(yd(j),W2(j),id{j});
    end

    figure_size = [100, 100, 2000,2000];  % [left, bottom, width, height]
    set(gcf, 'Position', figure_size);

    % 保存调整后的图形
    saveas(gcf, sprintf('%s.jpg', column_names{i}));
    hold off

    results = ols(W2,yd);
    vnames=strvcat('W2','莫兰指数');

    % 保存结果到txt文件
    % 开始记录输出到文件
    if exist(output_filename, 'file')
        delete(output_filename);
    end
    diary(output_filename);
    fprintf( 'Output information for %s:\n', column_names{i});
    prt(results,vnames);
    % 结束记录
    diary off;
end