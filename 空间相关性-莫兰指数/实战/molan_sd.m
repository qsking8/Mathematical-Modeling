% ��ȡExcel�ļ�
filename = 'C:\Users\65349\Desktop\Mathematical-Modeling\Mathematical-Modeling\�ռ������-Ī��ָ��\ʵս\31ʡ����.xlsx';
data = readtable(filename, 'Sheet', '����ָ������2022');
W = readmatrix(filename, 'Sheet', '�ռ�Ȩ�ؾ���');
name=data(:, 1).Variables;

% ��ȡ��������
column_names = data.Properties.VariableNames;

% ѭ�������5�е���14�е�����
for i = 5:14
    % ��ȡy�е�����
    y = data(:, i).Variables;
    output_filename = sprintf('%s.txt', column_names{i});
    title_str = sprintf('%s Ī��ָ��', column_names{i});
    
    yd=y-mean(y);
    m=length(y(:));
    p=(max(yd)*10)/10 + 0.005;
    p2=((-10)*min(yd))/(-10)- 0.005;
    W=normw(W);
    W2=W*yd;
    p3=(max(W2)*10)/10 + 0.005;
    p4=((-10)*min(W2))/(-10)- 0.005;
    a=[p2,p];%x
    b=[p4,p3];%y��
    
    figure('visible', 'off');
    scatter(yd,W2,'ro');
    grid on 
    axis([a, b]);  % ���������᷶Χ
    % ��������ļ����ͱ���
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

    % ����������ͼ��
    saveas(gcf, sprintf('%s.jpg', column_names{i}));
    hold off

    results = ols(W2,yd);
    vnames=strvcat('W2','Ī��ָ��');

    % ��������txt�ļ�
    % ��ʼ��¼������ļ�
    if exist(output_filename, 'file')
        delete(output_filename);
    end
    diary(output_filename);
    fprintf( 'Output information for %s:\n', column_names{i});
    prt(results,vnames);
    % ������¼
    diary off;
end